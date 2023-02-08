
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';

class FixedProductCard extends StatefulWidget {

  final QueryDocumentSnapshot<Object?> data;
  final QueryDocumentSnapshot<Object?> snap;

  const FixedProductCard({Key? key, required this.data, required this.snap}) : super(key: key);

  @override
  State<FixedProductCard> createState() => _FixedProductCardState();
}

class _FixedProductCardState extends State<FixedProductCard> {

  bool tapped = false;

  @override
  Widget build(BuildContext context) {

    int finalPrice = int.parse(widget.data['wholesale_price']) * int.parse(widget.snap[widget.data['pid']]['quantity']);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: shadowBlueColor,
                offset: Offset(0.0, 0.0),
                blurRadius: 4
            ),
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
              widget.data['photo_url'],
              fit: BoxFit.fill,
            ),
          ),
          20.widthBox,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['p_name'],
                style: const TextStyle(
                  fontFamily: "Lato",
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              6.heightBox,
              Text(
                "Total Amount: \$ $finalPrice",
                style: const TextStyle(
                  fontFamily: "Lato",
                  color: textDarkGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              6.heightBox,
              Text(
                "Quantity: ${widget.snap[widget.data['pid']]['quantity']}", //${widget.snap[widget.data['pid']]['quantity']}
                style: const TextStyle(
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
