
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/admin_screens/admin_main_screen.dart';

import '../../controller/kyc_controller.dart';

class KYCRequestsScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;
  const KYCRequestsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<KYCRequestsScreen> createState() => _KYCRequestsScreenState();
}

class _KYCRequestsScreenState extends State<KYCRequestsScreen> {

  var controller = Get.put(KYCController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: blueGradient,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.heightBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                      12.widthBox,
                      const Expanded(child: Text(
                        "KYC Detail",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      ),
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    12.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("Name:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("Phone Number:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['mobileNumber'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("Email Address:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['email'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("Aadhar Number:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['aadhar_number'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("PAN Number:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['pan_number'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Text("GST Number:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          6.widthBox,
                          Text(widget.data['gst_number'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text("Aadhar Card (Front):",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          12.heightBox,
                          Image.network(widget.data['aadhar_front_url'], fit: BoxFit.fitWidth,),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text("Aadhar Card (Back):",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          12.heightBox,
                          Image.network(widget.data['aadhar_back_url'], fit: BoxFit.fitWidth,),
                        ],
                      ),
                    ),
                    6.heightBox,
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text("Shop Image:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          12.heightBox,
                          Image.network(widget.data['shop_url'], fit: BoxFit.fitWidth,),
                        ],
                      ),
                    ),
                    16.heightBox,
                    Obx(()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: buttonColor,),) :  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MainButton(
                              btnText: "Accept",
                              onTap: () async {
                                controller.isLoading(true);
                                await controller.acceptKYCEvent(uid: widget.data['uid'], context: context);
                                Get.back();
                              },
                              color: buttonGreen,
                            ),
                          ),
                          12.widthBox,
                          Expanded(
                            child: MainButton(
                              btnText: "Decline",
                              onTap: () async {
                                controller.isLoading(true);
                                await controller.declineKYCEvent(uid: widget.data['uid'], context: context);
                                Get.back();
                              },
                              color: buttonRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    36.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
