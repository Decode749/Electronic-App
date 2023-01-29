
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/auth_screen/kyc_screens/kyc_details_screen.dart';
import 'package:mart_app/views/auth_screen/kyc_screens/not_approved_screen.dart';
import 'package:mart_app/views/auth_screen/login_screen.dart';
import 'package:mart_app/views/wholesale_screens/home_screen/rw_home_screen.dart';
import 'views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          fontFamily: "Lato"
      ),
      home: const SplashScreen()
    );
  }
}


