import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/auth_screen/signup_screen.dart';

import '../admin_screens/admin_main_screen.dart';
import '../wholesale_screens/home_screen/rw_home_screen.dart';
import 'kyc_screens/kyc_details_screen.dart';
import 'kyc_screens/not_approved_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? selected ;

  final loginOptions = ['Login for Wholesale','Login as Admin'];

  DropdownMenuItem buildMenuItem(String item) {
    return DropdownMenuItem(value: item, child:
        item.text
        .fontFamily("Lato")
        .fontWeight(FontWeight.w400).make(),
    );
  }
  @override
  void initState() {
    super.initState();
    selected = loginOptions[0];
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  int selectedItem = 0;

  void validateAdmin(context) {

    FirebaseFirestore.instance
        .collection(adminCollection)
        .get()
        .then((QuerySnapshot snapshot) async {
          var doc = snapshot.docs[0];
          if(emailController.text == doc['email'] && passwordController.text == doc['password']){
            await controller.loginMethod(
              context: context,
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ).then((value){
              if(value != null){
                controller.isLoading(false);
                showSnackBar("Login successful", context);
                Get.offAll(() => const NavScreen());
              }else{
                controller.isLoading(false);
              }
            }).onError((error, stackTrace) {
              controller.isLoading(false);
              showSnackBar(error.toString(), context);
            });
          }
          else{
            controller.isLoading(false);
            showSnackBar("Wrong email or password", context);
          }
    });
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Obx (() => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryPurpleColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(
                                    0.5,0.5
                                  ),
                                  blurRadius: 1.0,
                              )],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: loginOptions.map(buildMenuItem).toList(),
                                value: selected,
                                isDense: true,
                                elevation: 2,
                                dropdownColor: primaryPurpleColor,
                                borderRadius: BorderRadius.circular(6),
                                isExpanded: true,
                                onChanged: (val){
                                  setState(() {
                                    selected = val;
                                    selectedItem = loginOptions.indexOf(selected!);
                                  });
                                },
                        ),
                            ),
                          ),
                          20.heightBox,
                          const Divider(color: textBorderColor,height: 2,thickness: 1,),
                          20.heightBox,
                          CustomTextField(
                            controller: emailController,
                            hintText: "Enter your email address",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          12.heightBox,
                          CustomTextField(
                            controller: passwordController,
                            hintText: "Enter your password",
                            isPass: true,
                          ),
                          20.heightBox,
                          controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: buttonColor,),) :
                          MainButton(
                                btnText: "Login",
                                onTap: () async {
                                  controller.isLoading(true);
                                  if(selectedItem == 1){
                                    validateAdmin(context);
                                  }else{

                                    await controller.loginMethod(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ).then((value) async {
                                      if(value != null){
                                        await FirebaseFirestore.instance
                                            .collection(usersCollection)
                                            .doc(currentUser!.uid)
                                            .get()
                                            .then((DocumentSnapshot snap){
                                          if(snap['isApproved'] == true){
                                            Get.off(()=> const HomeScreen());
                                          } else {
                                            if(snap['kycReqSent'] == true){
                                              Get.off(()=> const KYCApprovalScreen());
                                            } else {
                                              Get.off(()=> const KYCDetailScreen());
                                            }
                                          }
                                        });

                                        controller.isLoading(false);
                                        showSnackBar("Login successful", context);

                                      } else{
                                        controller.isLoading(false);
                                      }
                                    }).onError((error, stackTrace) {
                                      controller.isLoading(false);
                                      showSnackBar(error.toString(), context);
                                    });
                                  }
                                }
                            ),
                          36.heightBox,
                          GestureDetector(
                            onTap: (){},
                            child: "Forget Password?"
                                .text.size(14)
                                .fontFamily("Lato")
                                .fontWeight(FontWeight.w700)
                                .makeCentered(),
                          ),
                          24.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Don't have an account?".text
                                  .fontFamily("Lato")
                                  .fontWeight(FontWeight.w700).make(),
                              4.widthBox,
                              GestureDetector(
                                onTap: (){
                                  Get.to(const SignupScreen());
                                },
                                child: "Sign up"
                                    .text.size(14)
                                    .color(buttonColor)
                                    .fontFamily("Lato")
                                    .fontWeight(FontWeight.w700)
                                    .makeCentered(),
                              ),
                            ],
                          ),],
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
