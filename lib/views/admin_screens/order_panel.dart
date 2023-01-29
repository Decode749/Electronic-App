import 'package:mart_app/constants/consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OrderPanelWidget extends StatefulWidget {

  final ScrollController controller;

  final PanelController panelController;

  const OrderPanelWidget({
    Key? key,
    required this.controller,
    required this.panelController
  }) : super(key: key);

  @override
  State<OrderPanelWidget> createState() => _OrderPanelWidgetState();
}

class _OrderPanelWidgetState extends State<OrderPanelWidget> {

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            color: darkGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0,
                    0.5,
                  ),
                  blurRadius: 1,
                  spreadRadius: 0,
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.heightBox,
              GestureDetector(
                onTap: (){
                  togglePanel();
                },
                child: Container(
                  height: 6,
                  width: 32,
                  decoration: BoxDecoration(
                    color: textDarkGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              16.heightBox,
              const Text(
                "Details",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              12.heightBox,
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            controller: widget.controller,
            children: [
              // content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.heightBox,
                    //
                    const Center(
                      child: Text(
                        "Order ID: #3434",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Date & Time: 23-12-2022, 13:30",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Status:",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Payment: \$ 3000",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Transaction ID: 1212203",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    6.heightBox,
                    const Divider(),
                    6.heightBox,
                    const Center(
                      child: Text(
                        "Product Details",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Product Name",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Product ID",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Price",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    6.heightBox,
                    const Divider(),
                    6.heightBox,
                    const Center(
                      child: Text(
                        "Customer Details",
                        style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Customer Name",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Customer Address",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "City",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "State",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Pincode",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Contact Number",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),

                    12.heightBox,
                    const Text(
                      "Registered Mobile Number",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    12.heightBox,
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    36.heightBox,
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
