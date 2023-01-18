import 'package:mart_app/common/widgets/added_widget.dart';
import 'package:mart_app/constants/consts.dart';

import '../views/retail_screens/product_screen/product_screen.dart';

class SmallProductCardVertical extends StatefulWidget {
  const SmallProductCardVertical({Key? key}) : super(key: key);

  @override
  State<SmallProductCardVertical> createState() => _SmallProductCardVerticalState();
}

class _SmallProductCardVerticalState extends State<SmallProductCardVertical> {

  bool tapped = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: (){
              Get.to(const ProductScreen());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    "https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png",
                    fit: BoxFit.fill,
                  ),
                ),
                12.heightBox,
                const Text(
                  "Product Name",
                  style: TextStyle(
                    fontFamily: "Lato",
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                6.heightBox,
                const Text(
                  "\$ 200",
                  style: TextStyle(
                    fontFamily: "Lato",
                    color: textDarkGreyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          8.heightBox,
          !tapped? MainButton(
            btnText: "Add to Cart",
            onTap: (){
              setState(() {
                tapped = true;
              });
            },
            vertPadding: 8,
            radius: 8,
          ) : const AddedWidget(),
        ],
      ),
    );
  }
}
