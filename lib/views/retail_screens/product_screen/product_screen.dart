import 'package:mart_app/constants/consts.dart';

import '../../../common/small_product_card_vert.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
                        child: const Icon(Icons.favorite_border, color: Colors.white,),
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
                      Scrollbar(
                        child: Column(
                          children: [
                            VxSwiper.builder(
                              enableInfiniteScroll: false,
                              itemCount: 3,
                              itemBuilder: (context, index){
                                return Image.network(
                                'https://i.pinimg.com/originals/52/11/96/521196ef0f94d8eea990b49bc801acc8.png',
                                width: double.infinity,
                                fit: BoxFit.fill,
                                );
                              },
                            ),
                            12.heightBox
                          ],
                        ),
                      ),
                      Positioned(
                        left: 12,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: redColor,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text("50%", style: TextStyle(color: Colors.white),),
                                Text("off", style: TextStyle(color: Colors.white),),
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
                        24.heightBox,
                        const Text(
                          "Products you may like",
                          style: TextStyle(
                              fontFamily: "Lato",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        16.heightBox,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const CircleAvatar(
                          backgroundColor: tertiaryPurpleColor,
                          radius: 24,
                          child: Center(
                            child: Icon(Icons.arrow_back, color: Colors.black,),
                          ),
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: MainButton(
                          btnText: "Add to Cart",
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
