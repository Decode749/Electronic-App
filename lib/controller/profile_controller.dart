import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:uuid/uuid.dart';

import '../constants/firebase_const.dart';

class ProfileController extends GetxController{

  var isLoading = false.obs;

  updateName(String name) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name' : name
    }, SetOptions(merge: true));
  }

  updatePhone(String phone) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'mobileNumber': phone,
    }, SetOptions(merge: true));
  }

  updatePassword(String password) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'password': password,
    }, SetOptions(merge: true));
  }

  changeAuthPassword({email, password, newPassword, context}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
      print("updated password");
    }).catchError((e) {
      showSnackBar(e.toString(), context);
    });
  }

  String addressId = const Uuid().v1();

  addAddress({
    required houseNo,
    required streetNo,
    required locality,
    required landmark,
    required city,
    required state,
    required pincode,
    required contactNo,

  }) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'address': FieldValue.arrayUnion([{
        'address_code': addressId,
        'house_no': houseNo,
        'street_no': streetNo,
        'locality': locality,
        'landmark': landmark,
        'city': city,
        'state': state,
        'pincode': pincode,
        'contact_no': contactNo
      }])
    }, SetOptions(merge: true));
  }
  
}