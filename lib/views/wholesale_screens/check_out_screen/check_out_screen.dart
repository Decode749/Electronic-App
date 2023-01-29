import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/views/wholesale_screens/check_out_screen/panel_widget.dart';
import '../../../common/fixed_product_card.dart';
import '../pay_screen/pay_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  final panelController = PanelController();

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
      ),
    );
  }
}
