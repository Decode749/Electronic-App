import '../constants/firebase_const.dart';

class FirestoreServices {

  // get users data
  static getUser(uid){
    return firestore.collection(usersCollection).where('uid', isEqualTo: uid).snapshots();
  }

  // get pending kyc users
  static getPendingKYC(){
    return firestore.collection(usersCollection).where('kycReqSent', isEqualTo: true).where('isApproved', isEqualTo: false).snapshots();
  }

  static getAllProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  static getCartDetails({required uid}){
    return firestore.collection(cartCollection).where('uid', isEqualTo: uid).snapshots();
  }

  static getSpecificProducts({required pid}){
    return firestore.collection(productsCollection).where('pid', isEqualTo: pid).snapshots();
  }


}