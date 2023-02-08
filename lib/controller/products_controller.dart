import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';


class ProductsController extends GetxController{

  var isLoading = false.obs;

  var _pImage;
  var pImageLink;

  get pImage => _pImage;

  set pImage(pImage) {
    _pImage = pImage;
  }


  String productId = const Uuid().v1();

  pickImage({context}) async {
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if(img == null){
        return;
      } else {
        pImage = File(img.path);
        print("img_selected");
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  uploadImage() async {
    if(pImage != null){
      var filename = basename(pImage.path);
      var destination = 'images/products/$productId/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(pImage);
      pImageLink = await ref.getDownloadURL();
    }
  }

  updateImage({required pid}) async {
    if(pImage != null){
      var filename = basename(pImage.path);
      var destination = 'images/products/$pid/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(pImage);
      pImageLink = await ref.getDownloadURL();
      print("uploaded");
    }
  }

  uploadProduct({ pName, wholesalePrice, mrp, desc, context, minQuantity }) async {

    var store = firestore.collection(productsCollection).doc(productId);
    await store.set({
      'pid': productId,
      'p_name': pName,
      'wholesale_price' : wholesalePrice,
      'mrp': mrp,
      'min_quantity': minQuantity,
      'photo_url': pImageLink,
      'p_desc': desc,
      'available': true,
    }).then((value) {
      isLoading(false);
      showSnackBar("Product Uploaded", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
  }

  updateProduct({ pName, wholesalePrice, mrp, desc, context, minQuantity, required pid }) async {

    var store = firestore.collection(productsCollection).doc(pid);
    await pImageLink == null ? store.set({
      'p_name': pName,
      'wholesale_price' : wholesalePrice,
      'mrp': mrp,
      'min_quantity': minQuantity,
      'p_desc': desc,
      'available': true,
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);
      showSnackBar("Product Updated", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    }) : store.set({
      'p_name': pName,
      'wholesale_price' : wholesalePrice,
      'mrp': mrp,
      'min_quantity': minQuantity,
      'photo_url': pImageLink,
      'p_desc': desc,
      'available': true,
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);
      showSnackBar("Product Updated", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
  }

  unavailableProduct({ required bool available, required context, required pid }) async {

    var store = firestore.collection(productsCollection).doc(pid);
    await store.set({
      'available': available,
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);
      showSnackBar("Product updated", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
  }

  // Cart Operations

  addToCart({required pid, required quantity, required totalPrice, required productUrl, required minQuantity, required wholesalePrice, required context}) async {
    await firestore.collection(cartCollection).doc(currentUser!.uid).set({
      'uid' : currentUser!.uid,
      'cart' : FieldValue.arrayUnion([pid]),
      pid : {
        'productId': pid,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'min_qty': minQuantity,
        'wholesale_price': wholesalePrice,
        'product_url': productUrl,
      }
    }, SetOptions(merge: true)).onError((error, stackTrace) {
      showSnackBar(error.toString(), context);
    });
  }

  updateCart({required pid, required quantity, required totalPrice, required productUrl, required minQuantity, required wholesalePrice,  required context}) async {
    await firestore.collection(cartCollection).doc(currentUser!.uid).update({

      pid: {
        'productId': pid,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'min_qty': minQuantity,
        'wholesale_price': wholesalePrice,
        'product_url': productUrl,
      }
    }).onError((error, stackTrace) {
      showSnackBar(error.toString(), context);
    });
  }

  deleteCart({required pid, required context}) async {
    await firestore.collection(cartCollection).doc(currentUser!.uid).update({

      pid : FieldValue.delete(),
      'cart' : FieldValue.arrayRemove([pid]),
    }).onError((error, stackTrace) {
      showSnackBar(error.toString(), context);
    });
  }
}

