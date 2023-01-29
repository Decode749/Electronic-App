import 'package:flutter/services.dart';
import 'package:mart_app/constants/consts.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

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
                      "Product Name",
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.share, color: Colors.white,),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              20.heightBox,
              Stack(
                children:[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Image.network(
                          'https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        12.heightBox
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: redColor,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text("50%", style: TextStyle(color: Colors.white, fontSize: 14),),
                            Text("off", style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      ),
                    ),
                  )
                ]
              ),
              32.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Product Name",
                              style: TextStyle(
                                  fontFamily: "Lato",
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            14.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "\$ 400",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                12.widthBox,
                                const Text(
                                  "\$ 800",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      color: textDarkGreyColor,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                            14.heightBox,
                            const Text(
                              "Minimum Qty: 15",
                              style: TextStyle(
                                  fontFamily: "Lato",
                                  color: textDarkGreyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                        // star-rating
                        Column(
                          children: [
                            VxRating(
                              onRatingUpdate: (value){},
                              normalColor: Colors.grey,
                              selectionColor: goldenColor,
                              count: 5,
                              size: 18,
                              isSelectable: false,
                              stepInt: true,
                            ),
                            8.heightBox,
                            const Text("38 reviews",
                              style: TextStyle(
                                fontFamily: "Lato",
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),)
                          ],
                        )
                      ],
                    ),
                    6.heightBox,
                    const Divider(thickness: 2,),
                    6.heightBox,
                    const Text(
                      "Description / jndxiasn wndcdwn wn n n oinc nwk kwnon cka jnwkan bkjnck ds djkwk ckj jwdcne dw jkne w jk wk kwekj k w kdjnc k wqj  k jkwnkc wk wjk c eqk kwj kej kewkwjk ejc w",
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: textDarkGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    // Row of product cards
                    40.heightBox
                  ],
                ),
              )
            ],
          ),
        )
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                counter == 0 ?MainButton(
                  btnText: "Add to Cart",
                  onTap: (){
                    setState(() {
                      counter++;
                    });
                  },
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainButton(
                      btnText: "-",
                      textSize: 16,
                      onTap: (){
                        setState(() {
                          if(counter > 0){
                            counter--;
                          }
                        });
                      },
                      radius: 36,
                      horiPadding: 22,
                    ),
                    4.widthBox,
                    Flexible(
                      child: Container(
                        height: 48,
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
                      textSize: 16,
                      onTap: (){
                        setState(() {
                          counter++;
                        });
                      },
                      radius: 36,
                      horiPadding: 20,
                    ),
                  ],
                ),
                16.heightBox
              ],
            ),
          ),
        )
      ],
        ),
    );
  }
}
