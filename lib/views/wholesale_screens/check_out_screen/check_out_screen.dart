import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/wholesale_screens/check_out_screen/panel_widget.dart';
import '../../../common/fixed_product_card.dart';
import '../../../services/firestore_services.dart';
import '../pay_screen/pay_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {


  final panelController = PanelController();
  String? address;

  int totalAmount = 0;
  int totalItems = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        minHeight: 0.0,
        maxHeight: MediaQuery.of(context).size.height*0.86,
        panelBuilder: (controller) => PanelWidget(
          panelController: panelController,
          controller: controller,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
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
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                        12.widthBox,
                        const Expanded(child: Text(
                          "Check Out",
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
                      20.heightBox,
                      StreamBuilder(
                        stream: FirestoreServices.getCartDetails(uid: currentUser!.uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs[0]['cart'].length,
                                itemBuilder: (BuildContext context, index) {
                                  var data = snapshot.data!.docs[0];
                                  var productData = data['cart'][index];

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
                                            totalAmount = totalAmount + (int.parse(dataSnap['wholesale_price']) * int.parse(data[dataSnap['pid']]['quantity']));
                                            totalItems = totalItems + 1;
                                            // Main Stuff
                                            return Column(
                                              children: [
                                                FixedProductCard(data: dataSnap, snap: data),
                                                12.heightBox,
                                              ],
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
                      14.heightBox,
                      const Text(
                        "Add address",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      12.heightBox,
                      StreamBuilder(
                        stream: FirestoreServices.getUser(currentUser!.uid),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if (snapshot.connectionState == ConnectionState.active) {

                            if(snapshot.data!.docs[0]['address'].isEmpty){
                              return const Center(child: Text("No saved address"),);
                            } else {
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs[0]['address'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = snapshot.data!.docs[0];
                                    var productData = data['address'][index];

                                    return Column(
                                      children: [
                                        RadioListTile(
                                          title: Text(
                                            "${productData['house_no']}, ${productData['street_no']}, ${productData['city']}, ${productData['state']} - ${productData['pincode']}, ${productData['contact_no']}",
                                            style: const TextStyle(
                                              fontFamily: "Lato",
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),),
                                          value: index,
                                          groupValue: address,
                                          onChanged: (value){
                                            setState(() {
                                              address = value.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    );

                                  });
                            }

                          } else if (snapshot.hasError) {
                            return const Center(child: Text("Some Error Occurred"));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: buttonColor,
                              ),
                            );
                          }
                        }
                      ),
                      16.heightBox,
                      GestureDetector(
                        onTap: (){
                          panelController.open();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.add, color: buttonColor,),
                            8.widthBox,
                            const Text(
                              "Add a new address",
                              style: TextStyle(
                                  fontFamily: "Lato",
                                  color: buttonColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: shadowBlueColor,
                          offset: Offset(0.0, -1.0),
                          blurRadius: 4
                      ),
                    ]
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    MainButton(
                      btnText: "Continue",
                      onTap: () async {
                        setState(() { });

                        bool refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => PayScreen(
                          totalAmount: totalAmount,
                          totalItems: totalItems,
                        )));
                        if(refresh){
                          setState(() {
                            totalAmount = 0;
                            totalItems = 0;
                          });
                        }

                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
