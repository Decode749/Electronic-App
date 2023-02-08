import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart_app/constants/consts.dart';

class AuthController extends GetxController{

  var isLoading = false.obs;

  // login method
  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
    return userCredential;
  }

  // sign up method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      showSnackBar(e.toString(), context);
    }
    return userCredential;
  }

  // storing data method
  storeUserData({name, password, email, mobileNumber, uid}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'mobileNumber': mobileNumber,
      'uid': currentUser!.uid,
      'isApproved': false,
      'kycReqSent': false,
      'address': [],
      'prev_orders': [],
    });
  }

  // sign out
  signOutMethod(context) async {
    try {
      await auth.signOut();
      showSnackBar("Signed out", context);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}