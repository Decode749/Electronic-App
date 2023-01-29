import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/admin_screens/admin_nav_screens/admin_post_screen.dart';

import '../../../services/firestore_services.dart';
import '../../auth_screen/login_screen.dart';
import '../kyc_requests_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    return  Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AdminPostScreen());
        },
        label: const Text("Add Product",
          style: TextStyle(
              fontFamily: "Lato",
              color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: buttonColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
                    children: [
                      const Expanded(
                        child: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Get.put(AuthController()).signOutMethod(context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        ),
                      ),
                      8.widthBox
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FirestoreServices.getPendingKYC(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
                  if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator(color: buttonColor,));
                  } else {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        16.heightBox,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "KYC Requests",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        14.heightBox,
                        // KYC Requests panel
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){

                            var data = snapshot.data!.docs[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(() => KYCRequestsScreen(data: data));
                                  },
                                  child: Container(
                                    width: media.width,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    decoration: const BoxDecoration(
                                        color: lightGrey
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("Name",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  6.widthBox,
                                                  Text(data['name'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              4.heightBox,
                                              Row(
                                                children: [
                                                  const Text("Email Address",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  6.widthBox,
                                                  Text(data['email'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              4.heightBox,
                                              Row(
                                                children: [
                                                  const Text("Phone number",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  6.widthBox,
                                                  Text(data['mobileNumber'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.shade300,
                                          radius: 14,
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                4.heightBox,
                              ],
                            );
                          },
                        ),
                        84.heightBox
                      ],
                    );
                  }
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}


// Not in use right now
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: deepBlueColor
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text("Products",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      12.widthBox,
                      const Text(
                        "34",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              12.widthBox,
              Expanded(
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: deepBlueColor
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text("Orders",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      12.widthBox,
                      const Text(
                        "34",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          12.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: deepBlueColor
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text("Active Users",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      12.widthBox,
                      const Text(
                        "34",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              12.widthBox,
              Expanded(
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: deepBlueColor
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text("Pending Requests",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      12.widthBox,
                      const Text(
                        "34",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.heightBox,
        ],
      ),
    );
  }
}



