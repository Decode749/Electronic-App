
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/wholesale_screens/home_screen/rw_home_screen.dart';

import '../admin_screens/admin_main_screen.dart';
import '../admin_screens/admin_nav_screens/admin_dashboard_screen.dart';
import '../auth_screen/kyc_screens/kyc_details_screen.dart';
import '../auth_screen/kyc_screens/not_approved_screen.dart';
import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Method for changing the screen
  changeScreen() {

    var count = 1;

    var authState = auth.authStateChanges();
    Future.delayed(const Duration(seconds: 3), (){

      authState.listen((User? user) async {
        if(user == null && mounted){
          Get.off(()=> const LoginScreen());
        } else {
          if(currentUser!.uid == 'xt49SKgMMzRJS5C336OImbsl31o2'){
            Get.off(()=> const NavScreen());
          } else {
            if(count==1){
              await FirebaseFirestore.instance
                  .collection(usersCollection)
                  .doc(currentUser!.uid)
                  .get()
                  .then((DocumentSnapshot snap){
                if(snap["isApproved"] == true){
                  Get.off(()=> const HomeScreen());
                } else {
                  if(snap['kycReqSent'] == true){
                    Get.off(()=> const KYCApprovalScreen());
                  } else {
                    Get.off(()=> const KYCDetailScreen());
                  }
                }
              });
              count++;
            } else {
              Get.off(()=> const LoginScreen());
            }
          }
        }
      });
    });


  }

  @override
  void initState() {
    super.initState();
    changeScreen();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
          gradient: blueGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Container()),
                appname.text.white.size(28).fontFamily("Lato").fontWeight(FontWeight.w900).makeCentered(),
                24.heightBox,
                appversion.text.white.size(14).makeCentered(),
                Flexible(child: Container()),
                ("Made with love").text.white.size(16).fontFamily("Lato").makeCentered(),
                16.heightBox
              ]
          ),
        ),
      ),
    );



  }
}
