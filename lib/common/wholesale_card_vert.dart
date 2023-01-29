
import 'package:flutter/services.dart';
import 'package:mart_app/constants/consts.dart';

import '../views/wholesale_screens/product_screen/product_screen.dart';

class WholesaleCardVert extends StatefulWidget {
  final bool available;
  const WholesaleCardVert({Key? key, this.available = true}) : super(key: key);

  @override
  State<WholesaleCardVert> createState() => _WholesaleCardVertState();
}

class _WholesaleCardVertState extends State<WholesaleCardVert> {

  int counter = 0;

  final quantityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    quantityController.text = counter.toString();

    return Container(
      color: widget.available == false ? Colors.black26 : Colors.transparent,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: (){
                Get.to(const ProductScreen());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1/0.8,
                    child: Image.network(
                      "https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  12.heightBox,
                  const Text(
                    "Product Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    "Minimum Qty: 12",
                    style: TextStyle(
                      fontFamily: "Lato",
                      color: textDarkGreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            8.heightBox,
            counter == 0 ? MainButton(
              btnText: "Add to Cart",
              onTap: (){
                setState(() {
                  counter++;
                });
              },
              vertPadding: 8,
              radius: 8,
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainButton(
                  btnText: "-",
                  onTap: (){
                    setState(() {
                      if(counter > 0){
                        counter--;
                      }
                    });
                  },
                  vertPadding: 8,
                  horiPadding: 12,
                  radius: 8,
                ),
                4.widthBox,
                Flexible(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)
                    ),
                    child: Center(
                        child: TextField(
                          controller: quantityController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: <TextInputFormatter>[
                            // for below version 2 use this
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            // for version 2 and greater you can also use this
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSubmitted: (val){
                            if(val == ""){
                              setState((){
                                counter = 0;
                              });
                            } else {
                              setState(() {
                                counter = int.parse(val);
                              });
                            }
                          },
                        )
                    ),
                  ),
                ),
                4.widthBox,
                MainButton(
                  btnText: "+",
                  onTap: (){
                    setState(() {
                      counter++;
                    });
                  },
                  vertPadding: 8,
                  horiPadding: 12,
                  radius: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
