import 'package:mart_app/constants/consts.dart';

import 'kyc_screens/kyc_details_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  var controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(child: Container()),
                  "Enter your credentials".text.size(20).fontFamily("Lato").fontWeight(FontWeight.w700).makeCentered(),
                  36.heightBox,
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: nameController,
                              hintText: "Enter your name",
                            ),
                            12.heightBox,
                            CustomTextField(
                              controller: emailController,
                              hintText: "Enter your email address",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            12.heightBox,
                            CustomTextField(
                              controller: phoneController,
                              hintText: "Enter your mobile number",
                              keyboardType: TextInputType.phone,
                            ),
                            12.heightBox,
                            CustomTextField(
                              controller: passwordController,
                              hintText: "Enter your password",
                              isPass: true,
                            ),
                            20.heightBox,
                            controller.isLoading.value ? const Center(child: CircularProgressIndicator( color: buttonColor,)) : MainButton(
                                btnText: "Sign up",
                                onTap: () async {

                                  controller.isLoading(true);
                                  if(
                                    emailController.text.trim().isEmpty ||
                                    passwordController.text.trim().isEmpty ||
                                    nameController.text.trim().isEmpty ||
                                    phoneController.text.trim().isEmpty
                                  ){
                                    controller.isLoading(false);
                                    showSnackBar("Please fill all the details and try again", context);
                                  } else if (passwordController.text.trim().length < 6){
                                    controller.isLoading(false);
                                    showSnackBar("Password should atleast contain 6 characters", context);
                                  } else {
                                    try{
                                      await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value) {
                                        return controller.storeUserData(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                          name: nameController.text.trim(),
                                          mobileNumber: phoneController.text.trim(),
                                        );
                                      }).then((value) {
                                        controller.isLoading(false);
                                        showSnackBar("Registered Successfully", context);
                                        print("going to kvc");
                                        Get.offAll(() => const KYCDetailScreen());
                                      });
                                    } catch (e) {
                                      controller.isLoading(false);
                                      auth.signOut();
                                      showSnackBar(e.toString(), context);
                                    }
                                  }
                                }
                            ),
                            36.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Already have an account?".text
                                    .fontFamily("Lato")
                                    .fontWeight(FontWeight.w700).make(),
                                4.widthBox,
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: "Sign in"
                                      .text.size(14)
                                      .color(buttonColor)
                                      .fontFamily("Lato")
                                      .fontWeight(FontWeight.w700)
                                      .makeCentered(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),

                  Flexible(child: Container()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
