import 'package:mart_app/constants/consts.dart';

import '../home_screen/rw_home_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {

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
                        "Pay",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "\$ 1200",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                  12.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Total number of items",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: textDarkGreyColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "4 Products",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: textDarkGreyColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  12.heightBox,
                ],
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainButton(
                    btnText: "Pay",
                    onTap: (){
                      Get.offAll(const HomeScreen());
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
