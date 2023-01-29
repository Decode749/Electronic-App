import 'package:mart_app/constants/consts.dart';

class AdminOrderCard extends StatelessWidget {
  final Function()? onViewTap;
  const AdminOrderCard({Key? key, required this.onViewTap }) : super(key: key);

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
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 74,
                height: 74,
                child: Image.network(
                  "https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png",
                  fit: BoxFit.fill,
                ),
              ),
              12.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order #776",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    6.heightBox,
                    const Text(
                      "Address",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    6.heightBox,
                    const Text(
                      "Product Name (Product ID)",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: textDarkGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    6.heightBox,
                    Row(
                      children: [
                        const Text(
                          "\$ 200",
                          style: TextStyle(
                            fontFamily: "Lato",
                            color: textDarkGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.widthBox,
                        const Text(
                          "Qty: 24",
                          style: TextStyle(
                            fontFamily: "Lato",
                            color: textDarkGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.heightBox,
          MainButton(
            btnText: "View details",
            onTap: onViewTap,
            vertPadding: 8,
            radius: 6,
          ),
          8.heightBox,
          MainButton(
            btnText: "Mark as completed",
            onTap: (){},
            vertPadding: 8,
            radius: 6,
          ),
        ],
      ),
    );
  }
}
