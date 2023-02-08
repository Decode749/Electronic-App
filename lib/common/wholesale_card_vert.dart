import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mart_app/constants/consts.dart';

import '../controller/products_controller.dart';
import '../views/wholesale_screens/product_screen/product_screen.dart';

class WholesaleCardVert extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;

  final QueryDocumentSnapshot<Object?> snap;

  const WholesaleCardVert({Key? key, required this.data, required this.snap})
      : super(key: key);

  @override
  State<WholesaleCardVert> createState() => _WholesaleCardVertState();
}

class _WholesaleCardVertState extends State<WholesaleCardVert> {
  int counter = 0;
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

  final quantityController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   quantityController.dispose();
  //   controller.dispose();
  // }

  var totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    quantityController.text = counter.toString();
    var totalPrice = (counter + 1) * int.parse(widget.data['wholesale_price']!);

    return Container(
      decoration: BoxDecoration(
        color: widget.data['available'] == false
            ? Colors.grey.shade400
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: shadowBlueColor, offset: Offset(0.0, 0.0), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(ProductScreen(data: widget.data, snap: widget.snap,));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 0.8,
                  child: Image.network(
                    widget.data['photo_url'],
                    fit: BoxFit.fill,
                  ),
                ),
                12.heightBox,
                Text(
                  widget.data['p_name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Lato",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                6.heightBox,
                Text(
                  "\$ ${widget.data['wholesale_price']}",
                  style: const TextStyle(
                    fontFamily: "Lato",
                    color: textDarkGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                6.heightBox,
                Text(
                  "Minimum Qty: ${widget.data['min_quantity']}",
                  style: const TextStyle(
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
          widget.data['available'] == false
              ? const Center(
                  child: Text("Unavailable",
                      style: TextStyle(
                          color: redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)))
              : counter == int.parse(widget.data['min_quantity']!) - 1
                  ? MainButton(
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
                            context: context);
                      },
                      vertPadding: 8,
                      radius: 8,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainButton(
                          btnText: "-",
                          onTap: () async {
                            if ((counter) >
                                int.parse(widget.data['min_quantity']!)) {
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
                                  context: context);
                            } else {
                              setState(() {
                                counter--;
                              });
                              await controller.deleteCart(
                                  pid: widget.data['pid'], context: context);
                            }
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
                                borderRadius: BorderRadius.circular(18)),
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                // for version 2 and greater you can also use this
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSubmitted: (val) async {
                                if (val == "") {
                                  setState(() {
                                    counter =
                                        int.parse(widget.data['min_quantity']!);
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
                                  if (counter >
                                      int.parse(widget.data['min_quantity']!)) {
                                    setState(() {
                                      counter = int.parse(val);
                                    });
                                    await controller.updateCart(
                                        pid: widget.data['pid'],
                                        quantity: counter.toString(),
                                        totalPrice: totalPrice.toString(),
                                        productUrl: widget.data['photo_url'],
                                        minQuantity:
                                            widget.data['min_quantity'],
                                        wholesalePrice:
                                            widget.data['wholesale_price'],
                                        context: context);
                                  }
                                }
                              },
                            )),
                          ),
                        ),
                        4.widthBox,
                        MainButton(
                          btnText: "+",
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
                                context: context);
                          },
                          vertPadding: 8,
                          horiPadding: 12,
                          radius: 8,
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
