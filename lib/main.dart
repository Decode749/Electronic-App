
import 'dart:io';

import 'package:mart_app/constants/consts.dart';
import 'views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isIOS)
  {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDg3l8JbNSkAd1pYSZShM6-LB-a2TKV3g0', 
        appId: '1:353681085866:ios:27e8083823b6ac8ed287d3', 
        messagingSenderId: '353681085866', 
        projectId: 'electric-mart',
        storageBucket: 'electric-mart.appspot.com',
        )
    );
  }
  else
  {
    await Firebase.initializeApp();
  }
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


