import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';

import '../../../common/wholesale_card_vert.dart';
import '../../../services/firestore_services.dart';
import '../check_out_screen/check_out_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          child: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white)),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Your Cart",
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
            child: Scrollbar(
              child: StreamBuilder(
                stream: FirestoreServices.getCartDetails(uid: currentUser!.uid),
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
                        itemCount: snapshot.data!.docs[0]['cart'].length,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 16, bottom: 44),
                        itemBuilder: (BuildContext context, index) {
                          var data = snapshot.data!.docs[0];
                          var productData =
                              snapshot.data!.docs[0]['cart'][index];

                          return StreamBuilder(
                              stream: FirestoreServices.getSpecificProducts(
                                  pid: productData),
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
                                      data: dataSnap,
                                      snap: data,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: shadowBlueColor,
                          offset: Offset(0.0, -1.0),
                          blurRadius: 4),
                    ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: const [
                    //     Text(
                    //       "Total number of items",
                    //       style: TextStyle(
                    //         fontFamily: "Lato",
                    //         color: textDarkGreyColor,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //     Text(
                    //       "4 Products",
                    //       style: TextStyle(
                    //         fontFamily: "Lato",
                    //         color: textDarkGreyColor,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    MainButton(
                      btnText: "Check out",
                      onTap: () {
                        Get.to(const CheckOutScreen());
                      },
                    ),
                  ],
                ),
            ),
          )
        ],
      ),
    );
  }
}
