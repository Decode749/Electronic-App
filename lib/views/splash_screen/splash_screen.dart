
import 'package:mart_app/constants/consts.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Method for changing the screen
  changeScreen(){
    Future.delayed(const Duration(seconds: 3), (){
      Get.off(() => const LoginScreen());
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
