import 'package:mart_app/constants/consts.dart';

import '../../../common/fixed_product_card.dart';
import '../../../common/product_card_vertical.dart';
import '../pay_screen/pay_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  final houseNumController = TextEditingController();
  final streetController = TextEditingController();
  final localityController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    houseNumController.dispose();
    streetController.dispose();
    localityController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    contactController.dispose();
  }
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
                  16.heightBox,
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
                    const FixedProductCard(),
                    12.heightBox,
                    const FixedProductCard(),
                    12.heightBox,
                    const FixedProductCard(),
                    12.heightBox,
                    const FixedProductCard(),
                    12.heightBox,
                    const FixedProductCard(),
                    20.heightBox,
                    const Text(
                      "Add address",
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    16.heightBox,
                    CustomTextField(
                      controller: houseNumController,
                      hintText: "House/Apartment Number",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: streetController,
                      hintText: "Street",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: localityController,
                      hintText: "Locality",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: landmarkController,
                      hintText: "Landmark (optional)",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: cityController,
                      hintText: "City",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: stateController,
                      hintText: "State",
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: pincodeController,
                      hintText: "Pin Code",
                      keyboardType: TextInputType.number,
                    ),
                    6.heightBox,
                    CustomTextField(
                      controller: contactController,
                      hintText: "Contact Number",
                      keyboardType: TextInputType.phone,
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
                  color: secondaryPurpleColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, -1),
                        blurRadius: 2
                    )
                  ]
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "\$ 1200",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Total number of items",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: textDarkGreyColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "4 Products",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: textDarkGreyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  12.heightBox,
                  MainButton(
                    btnText: "Continue",
                    onTap: (){
                      Get.to(const PayScreen());
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
