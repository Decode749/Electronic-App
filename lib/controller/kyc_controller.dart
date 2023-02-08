import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:path/path.dart';
import '../constants/utils.dart';

class KYCController extends GetxController{

  var isLoading = false.obs;

  var pImage = List<dynamic>.generate(3, (index) => null);
  var pImageLinks = [];

  // 0 - var frontAadhar;
  // 1 - var backAadhar;
  // 2 - var shopImage;

  pickImage({required int index, required context}) async {
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if(img == null){
        return;
      } else {
        pImage[index] = File(img.path);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  uploadImage() async {
    for(var item in pImage){
      if(item != null){
        var filename = basename(item.path);
        var destination = 'images/${currentUser!.uid}//$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImageLinks.add(n);
      }
    }
  }

  uploadKYCDetails({ required aadharNum, required panNum, required gstNum , required context}) async {

    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'aadhar_number' : aadharNum,
      'pan_number': panNum,
      'gst_number': gstNum,
      'aadhar_front_url': pImageLinks[0],
      'aadhar_back_url': pImageLinks[1],
      'shop_url': pImageLinks[2],
    }, SetOptions(merge: true)).then((value) async {
      await store.set({
        'kycReqSent': true
      }, SetOptions(merge: true));
      isLoading(false);
      showSnackBar("KYC Request Sent", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
  }

  acceptKYCEvent({required uid, required context}) async {
    var store = firestore.collection(usersCollection).doc(uid);
    await store.set({
      'isApproved': true
    }, SetOptions(merge: true)).then((value) {
        isLoading(false);
        showSnackBar("KYC Accepted", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
    var store2 = firestore.collection(cartCollection).doc(uid);
    await store2.set({
      'uid': uid,
      'cart': [],
    });
  }

  declineKYCEvent({required uid, required context}) async {
    var store = firestore.collection(usersCollection).doc(uid);
    await store.set({
      'kycReqSent': false
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);
      showSnackBar("KYC Accepted", context);
    }).onError((error, stackTrace) {
      isLoading(false);
      showSnackBar(error.toString(), context);
    });
  }

}