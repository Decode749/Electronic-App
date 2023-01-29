import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/auth_screen/login_screen.dart';

import '../../../controller/profile_controller.dart';
import '../../../services/firestore_services.dart';
import '../../auth_screen/signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  var controller = Get.put(ProfileController());



  Future openDialog(type, title, inputType, data) {
    final textEditingController = TextEditingController();

    textEditingController.text = data;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Change $title",
        ),
        content: CustomTextField(
          controller: textEditingController,
          hintText: "Enter new $title",
          keyboardType: inputType,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if(type == 'name'){
                await controller.updateName(textEditingController.text);
                showSnackBar("Profile updated", context);
                Get.back();
              } else {
                await controller.updatePhone(textEditingController.text.toString());
                showSnackBar("Profile updated", context);
                Get.back();
              }
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  Future changePasswordDialog(data) {
    final oldPassEditingController = TextEditingController();
    final newPassEditingController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Change password",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: oldPassEditingController,
              hintText: "Enter old password",
              isPass: true,
            ),
            4.heightBox,
            CustomTextField(
              controller: newPassEditingController,
              hintText: "Enter new password",
              isPass: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if(newPassEditingController.text.length >= 6){
                if (oldPassEditingController.text == data['password']) {
                  await controller.changeAuthPassword(
                      email: data['email'],
                      password: data['password'],
                      newPassword: newPassEditingController.text,
                      context: context
                  );

                  await controller.updatePassword(newPassEditingController.text);

                  showSnackBar("Password updated", context);
                  Get.back();
                } else {
                  showSnackBar("Wrong password", context);
                }
              } else {
                showSnackBar("Password should contain atleast 6 characters", context);
              }
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                      12.widthBox,
                      const Expanded(child: Text(
                        "Your Profile",
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder(
                  stream: FirestoreServices.getUser(currentUser!.uid),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(color: buttonColor,));
                    } else {
                      var data = snapshot.data!.docs[0];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                        20.heightBox,
                        ProfileCard(
                          contentWidget: [
                            8.heightBox,
                            AccountTile(
                              title: "Name",
                              content: data['name'],
                              onTap: (){
                                openDialog(
                                    "name",
                                    "name",
                                    TextInputType.name,
                                    data['name']
                                );
                              },
                            ),
                            const Divider(height: 4,),
                            AccountTile(
                              title: "Phone Number",
                              content: data['mobileNumber'],
                              onTap: (){
                                openDialog("phone", "phone number", TextInputType.phone, data['mobileNumber']);
                              },
                            ),
                            const Divider(height: 4,),
                            AccountTile(
                              title: "Email Address",
                              content: data['email'],
                              isEdit: false,
                            ),
                          ],
                          cardTitle: "Your Account Details",
                        ),
                        16.heightBox,
                        ProfileCard(
                          contentWidget: [
                            8.heightBox,
                            const InfoTile(title: "Your saved address"),
                            const Divider(height: 4,),
                            const InfoTile(title: "Your previous orders"),
                            const Divider(height: 4,),
                            InfoTile(
                              title: "Change Password",
                              onTap: (){
                                changePasswordDialog(data);
                              },
                            ),
                          ],
                          cardTitle: "Your Information",
                        ),
                        16.heightBox,
                        ProfileCard(
                          contentWidget: [
                            8.heightBox,
                            const InfoTile(title: "About"),
                            const Divider(height: 4,),
                            const InfoTile(title: "Send feedback"),
                            const Divider(height: 4,),
                            const InfoTile(title: "Rate us on play store"),
                            const Divider(height: 4,),
                            InfoTile(
                              title: "Log out",
                              onTap: () async {
                                await Get.put(AuthController()).signOutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                            ),
                          ],
                          cardTitle: "More",
                        ),
                        36.heightBox,
                        ],
                      );
                    }
                  },
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const InfoTile({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: 14,
                ),
                8.widthBox,
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
                8.widthBox,
                Icon(Icons.arrow_forward_ios, color: Colors.grey.shade300,size: 20,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AccountTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isEdit;
  final Function()? onTap;
  const AccountTile({Key? key, required this.title, required this.content, this.isEdit = true, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: textDarkGreyColor,
              fontSize: 12,
            ),
          ),
          6.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              isEdit ? GestureDetector(
                onTap: onTap,
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: neonBlueColor,
                    fontSize: 12,
                  ),
                ),
              ) : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final List<Widget> contentWidget;
  final String cardTitle;
  const ProfileCard({Key? key, required this.contentWidget, required this.cardTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: shadowBlueColor,
                offset: Offset(0.0, 0.0),
                blurRadius: 4
            ),
          ]
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  color: neonBlueColor,
                ),
              ),
              14.widthBox,
              Text(
                cardTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              )
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: contentWidget,
            ),
          )
        ],
      ),
    );
  }
}


