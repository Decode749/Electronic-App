import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mart_app/constants/consts.dart';

import '../../../controller/products_controller.dart';

class ProductScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;

  final QueryDocumentSnapshot<Object?> snap;

  const ProductScreen({Key? key, required this.data, required this.snap}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  int counter = 0;

  final quantityController = TextEditingController();
  var controller = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();

    try {
      counter = int.parse(widget.snap[widget.data['pid']]['quantity']);
    } catch (e) {
      counter = int.parse(widget.data['min_quantity']!) - 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    quantityController.text = counter.toString();
    final name = widget.data['p_name'];
    final wholesalePrice = widget.data['wholesale_price'];
    final mrp = widget.data['mrp'];

    final intWholesalePrice = int.parse(wholesalePrice);
    final intMRP = int.parse(mrp);
    final discount = ((intMRP - intWholesalePrice)/intMRP)*100;

    var totalPrice = (counter + 1) * int.parse(widget.data['wholesale_price']!);

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
                    Expanded(child: Text(
                      name,
                      style: const TextStyle(
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
                          widget.data['photo_url'],
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        24.heightBox
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
                          children: [
                            Text("${discount.toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 14),),
                            const Text("off", style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      ),
                    ),
                  )
                ]
              ),
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
                            Text(
                              name,
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            14.heightBox,
                            Row(
                              children: [
                                Text(
                                  "\$ $wholesalePrice",
                                  style: const TextStyle(
                                      fontFamily: "Lato",
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                12.widthBox,
                                Text(
                                  "\$ $mrp",
                                  style: const TextStyle(
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
                            Text(
                              "Minimum Qty: ${widget.data['min_quantity']}",
                              style: const TextStyle(
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
                    Text(
                      widget.data['p_desc'],
                      style: const TextStyle(
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
                12.heightBox,
                widget.data['available'] == false ? const Center(child: Text("Unavailable", style: TextStyle(color: redColor, fontSize: 16, fontWeight: FontWeight.w600))) : counter == widget.data['min_quantity'] ? MainButton(
                  btnText: "Add to Cart",
                  onTap: () async {
                    setState(() {
                      counter++;
                    });
                    await controller.addToCart(
                        pid: widget.data['pid'],
                        quantity: counter.toString(),
                        totalPrice: totalPrice.toString(),
                        productUrl: widget.data['photo_url'],
                        minQuantity: widget.data['min_quantity'],
                        wholesalePrice: widget.data['wholesale_price'],
                        context: context
                    );
                  },
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainButton(
                      btnText: "-",
                      textSize: 16,
                      onTap: () async {
                        if(counter > widget.data['min_quantity']){
                          setState(() {
                            counter--;
                          });
                          await controller.updateCart(
                              pid: widget.data['pid'],
                              quantity: counter.toString(),
                              totalPrice: totalPrice.toString(),
                              productUrl: widget.data['photo_url'],
                              minQuantity: widget.data['min_quantity'],
                              wholesalePrice: widget.data['wholesale_price'],
                              context: context
                          );
                        } else {
                          setState(() {
                            counter--;
                          });
                          await controller.deleteCart(
                              pid: widget.data['pid'], context: context);
                        }
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
                              onSubmitted: (val) async {
                                if(val == ""){
                                  setState((){
                                    counter = int.parse(widget.data['min_quantity']!);
                                  });
                                  await controller.deleteCart(
                                      pid: widget.data['pid'],
                                      context: context);
                                } else if (int.parse(val) <
                                    int.parse(widget.data['min_quantity']!)) {
                                  setState(() {
                                    counter =
                                        int.parse(widget.data['min_quantity']!);
                                  });
                                  await controller.deleteCart(
                                      pid: widget.data['pid'],
                                      context: context);
                                } else {
                                  if(counter > int.parse(widget.data['min_quantity']!)) {
                                    setState(() {
                                      counter = int.parse(val);
                                    });
                                    await controller.updateCart(
                                        pid: widget.data['pid'],
                                        quantity: counter.toString(),
                                        totalPrice: totalPrice.toString(),
                                        productUrl: widget.data['photo_url'],
                                        minQuantity: widget.data['min_quantity'],
                                        wholesalePrice: widget.data['wholesale_price'],
                                        context: context
                                    );
                                  }
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
                      onTap: () async {
                        setState(() {
                          counter++;
                        });
                        await controller.updateCart(
                            pid: widget.data['pid'],
                            quantity: counter.toString(),
                            totalPrice: totalPrice.toString(),
                            productUrl: widget.data['photo_url'],
                            minQuantity: widget.data['min_quantity'],
                            wholesalePrice: widget.data['wholesale_price'],
                            context: context
                        );
                      },
                      radius: 36,
                      horiPadding: 20,
                    ),
                  ],
                ),
                12.heightBox
              ],
            ),
          ),
        )
      ],
        ),
    );
  }
}
