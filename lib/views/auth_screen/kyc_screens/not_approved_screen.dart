
import 'package:mart_app/constants/consts.dart';

import '../login_screen.dart';

class KYCApprovalScreen extends StatefulWidget {
  const KYCApprovalScreen({Key? key}) : super(key: key);

  @override
  State<KYCApprovalScreen> createState() => _KYCApprovalScreenState();
}

class _KYCApprovalScreenState extends State<KYCApprovalScreen> {

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
                "Approval is pending".text.white.size(28).fontFamily("Lato").fontWeight(FontWeight.w900).makeCentered(),
                24.heightBox,
                "Come back later".text.white.size(16).fontFamily("Lato").fontWeight(FontWeight.w600).makeCentered(),

                Flexible(child: Container()),
                GestureDetector(
                  onTap: () async {
                    await Get.put(AuthController()).signOutMethod(context);
                    Get.offAll(() => const LoginScreen());
                  },
                  child: "Click here to log out"
                      .text.size(16)
                      .color(Colors.white)
                      .fontFamily("Lato")
                      .fontWeight(FontWeight.w700)
                      .makeCentered(),
                ),
                36.heightBox
              ]
          ),
        ),
      ),
    );
  }
}
