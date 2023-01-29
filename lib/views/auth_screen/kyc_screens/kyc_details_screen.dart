import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/auth_screen/login_screen.dart';
import '../../../controller/kyc_controller.dart';
import '../../../controller/products_controller.dart';
import 'not_approved_screen.dart';


class KYCDetailScreen extends StatefulWidget {
  const KYCDetailScreen({Key? key}) : super(key: key);

  @override
  State<KYCDetailScreen> createState() => _KYCDetailScreenState();
}

class _KYCDetailScreenState extends State<KYCDetailScreen> {


  var controller = Get.put(KYCController());

  final aadhaarNumberController = TextEditingController();
  final panCardController = TextEditingController();
  final gstinNumController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    aadhaarNumberController.dispose();
    panCardController.dispose();
    gstinNumController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              44.heightBox,
              "Let's get your KYC done".text.size(20).fontFamily("Lato").fontWeight(FontWeight.w700).makeCentered(),
              36.heightBox,
              Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: aadhaarNumberController,
                      hintText: "Enter your Aadhaar Card number",
                      keyboardType: TextInputType.number,
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: panCardController,
                      hintText: "Enter your PAN Card number (optional)",
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: gstinNumController,
                      hintText: "Enter your GSTIN number (optional)",
                    ),
                    8.heightBox,
                    GestureDetector(
                      onTap: () async {
                        await controller.pickImage(context: context, index: 0);
                        setState(() {});
                      },
                      child: AspectRatio(
                        aspectRatio: 86/54,
                        child: controller.pImage[0] != null ? Image.file(controller.pImage[0] , fit: BoxFit.cover,) : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: textBorderColor)
                          ),
                          child:
                          "Upload your Aadhaar Card (front-side)".text.size(14).fontFamily("Lato").fontWeight(FontWeight.w400).makeCentered(),
                        ),
                      ),
                    ),
                    8.heightBox,
                    GestureDetector(
                      onTap: () async {
                        await controller.pickImage(context: context, index: 1);
                        setState(() {});
                      },
                      child: AspectRatio(
                        aspectRatio: 86/54,
                        child: controller.pImage[1] != null ? Image.file(controller.pImage[1], fit: BoxFit.cover,) : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: textBorderColor)
                          ),
                          child:
                          "Upload your Aadhaar Card (back-side)".text.size(14).fontFamily("Lato").fontWeight(FontWeight.w400).makeCentered(),
                        ),
                      ),
                    ),
                    8. heightBox,
                    GestureDetector(
                      onTap: () async {
                        await controller.pickImage(context: context, index: 2);
                        setState(() {});
                      },
                      child: AspectRatio(
                        aspectRatio: 3/4,
                        child: controller.pImage[2] != null ? Image.file(controller.pImage[2] , fit: BoxFit.cover,) : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: textBorderColor)
                                ),
                                child: "Submit your shop photo".text.size(14).fontFamily("Lato").fontWeight(FontWeight.w400).makeCentered(),
                            ),
                      ),
                    ),
                    20.heightBox,
                    Obx(()=>
                      controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: buttonColor,),) : MainButton(
                        btnText: "Submit details",
                        onTap: () async {
                          if(
                            aadhaarNumberController.text.toString().length == 12 &&
                            controller.pImage[0] != null &&
                            controller.pImage[1] != null &&
                            controller.pImage[2] != null ){

                            controller.isLoading(true);
                            await controller.uploadImage();
                            await controller.uploadKYCDetails(
                              aadharNum: aadhaarNumberController.text.toString(),
                              panNum: panCardController.text.toString(),
                              gstNum: gstinNumController.text.toString(),
                              context: context,
                            );
                            Get.off(() => const KYCApprovalScreen());
                          } else {
                            showSnackBar("Please fill all your details carefully", context);
                          }
                        }
                      ),
                    ),
                    28.heightBox,
                    GestureDetector(
                      onTap: () async {
                        await Get.put(AuthController()).signOutMethod(context);
                        Get.offAll(() => const LoginScreen());
                      },
                      child: "Go back to login"
                          .text.size(14)
                          .color(buttonColor)
                          .fontFamily("Lato")
                          .fontWeight(FontWeight.w700)
                          .makeCentered(),
                    ),
                    36.heightBox
                  ],
                ) ,
              ),
            ],
          ),
        )
      ),
    );
  }
}
