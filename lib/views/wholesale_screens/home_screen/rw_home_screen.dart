import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import '../../../common/wholesale_card_vert.dart';
import '../../../services/firestore_services.dart';
import '../cart_screen/cart_screen.dart';
import '../user_profile/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
                      const Expanded(
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontFamily: "Lato",
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      14.widthBox,
                      GestureDetector(
                        onTap: () async {
                          bool refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                          if(refresh){
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: const [
                            Icon(Icons.shopping_cart_rounded,
                                color: Colors.white),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 4,
                            ),
                          ],
                        ),
                      ),
                      14.widthBox,
                      GestureDetector(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: const Icon(Icons.person, color: Colors.white)),
                    ],
                  ),
                  16.heightBox,
                  CustomTextField(
                    controller: searchController,
                    hintText: "Search products...",
                    fillColor: Colors.white,
                    hintColor: textDarkGreyColor,
                    borderColor: Colors.white,
                  ),
                  16.heightBox,
                ],
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: StreamBuilder(
                stream: FirestoreServices.getAllProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                            childAspectRatio: (1 / 1.55),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                        itemCount: snapshot.data!.docs.length,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 16, bottom: 44),
                        itemBuilder: (BuildContext context, index) {
                          var data = snapshot.data!.docs[index];

                          return StreamBuilder(
                              stream: FirestoreServices.getCartDetails(
                                  uid: currentUser!.uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snap) {
                                if (snap.connectionState ==
                                    ConnectionState.active) {
                                  var dataSnap = snap.data!.docs[0];

                                  if (!snap.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: buttonColor,
                                    ));
                                  } else {
                                    return WholesaleCardVert(
                                      data: data,
                                      snap: dataSnap,
                                    );
                                  }
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: buttonColor,
                                  ));
                                }
                              });
                        });
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Some Error Occurred"));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: buttonColor,
                    ));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
