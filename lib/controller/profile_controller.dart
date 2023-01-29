import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart_app/constants/consts.dart';

import '../constants/firebase_const.dart';

class ProfileController extends GetxController{

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
  
}