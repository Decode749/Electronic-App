import 'dart:io';
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


}