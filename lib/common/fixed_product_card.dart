import 'package:mart_app/common/widgets/added_widget.dart';
import 'package:mart_app/constants/consts.dart';

class FixedProductCard extends StatefulWidget {
  const FixedProductCard({Key? key}) : super(key: key);

  @override
  State<FixedProductCard> createState() => _FixedProductCardState();
}

class _FixedProductCardState extends State<FixedProductCard> {

  bool tapped = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: primaryPurpleColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 1
            )
          ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 74,
            width: 74,
            child: Image.network(
              "https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png",
              fit: BoxFit.fill,
            ),
          ),
          20.widthBox,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Product Name",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              6.heightBox,
              const Text(
                "\$ 200",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: textDarkGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              6.heightBox,
              const Text(
                "Quantity: 1",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: textDarkGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
