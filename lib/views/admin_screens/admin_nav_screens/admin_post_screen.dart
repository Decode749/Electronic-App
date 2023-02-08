import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';

import '../../../controller/products_controller.dart';

class AdminPostScreen extends StatefulWidget {
  final bool isEdit;
  final QueryDocumentSnapshot<Object?>? data;
  const AdminPostScreen({Key? key, this.isEdit = false, this.data}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {

  var controller = Get.put(ProductsController());

  final productNameController = TextEditingController();
  final mrpController = TextEditingController();
  final wholesalePriceController = TextEditingController();
  final wholesaleQtyController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.isEdit){
      productNameController.text = widget.data!['p_name'];
      mrpController.text = widget.data!['mrp'];
      wholesaleQtyController.text = widget.data!['min_quantity'];
      wholesalePriceController.text = widget.data!['wholesale_price'];
      descriptionController.text = widget.data!['p_desc'];
    }
  }

  @override
  void dispose() {
    super.dispose();

    productNameController.dispose();
    mrpController.dispose();
    wholesalePriceController.dispose();
    wholesaleQtyController.dispose();
    descriptionController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                      12.widthBox,
                       Expanded(
                         child: widget.isEdit ? const Text(
                            "Edit Product Details",
                            style: TextStyle(
                                fontFamily: "Lato",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ) : const Text(
                           "Add Product",
                           style: TextStyle(
                               fontFamily: "Lato",
                               color: Colors.white,
                               fontSize: 20,
                               fontWeight: FontWeight.w700),
                         ),
                      ),
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ),
          Obx(() => Expanded(
              child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: buttonColor,)) : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      20.heightBox,
                      GestureDetector(
                        onTap: () async {
                          await controller.pickImage(context: context);
                          setState(() {});
                        },
                        child: AspectRatio(
                          aspectRatio: 1/1,
                          child: controller.pImage != null ? Image.file(controller.pImage, fit: BoxFit.cover,) : widget.isEdit ? Image.network(widget.data!['photo_url'], fit: BoxFit.cover,) : Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black26,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  SizedBox(height: 12,),
                                  Text(
                                    "Add photo",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      const Text(
                        "Add details",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      16.heightBox,
                      CustomTextField(
                        controller: productNameController,
                        hintText: "Name of the product",
                      ),
                      6.heightBox,
                      CustomTextField(
                        controller: mrpController,
                        hintText: "Maximum Retail Price",
                        keyboardType: TextInputType.number,
                      ),
                      6.heightBox,
                      CustomTextField(
                        controller: wholesalePriceController,
                        hintText: "Wholesale Price",
                        keyboardType: TextInputType.number,
                      ),
                      6.heightBox,
                      CustomTextField(
                        controller: wholesaleQtyController,
                        hintText: "Wholesale minimum quantity",
                        keyboardType: TextInputType.number,
                      ),
                      6.heightBox,
                      CustomTextField(
                        controller: descriptionController,
                        hintText: "Product description",
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      ),
                      20.heightBox,
                      MainButton(
                          btnText: widget.isEdit ? "Update Product" : "Add Product",
                          onTap: widget.isEdit ? () async {
                            controller.isLoading(true);
                            if(controller.pImage != null){
                              await controller.updateImage(pid: widget.data!['pid']);
                            }
                            await controller.updateProduct(
                              pid: widget.data!['pid'],
                              pName: productNameController.text,
                              mrp: mrpController.text.toString(),
                              wholesalePrice: wholesalePriceController.text.toString(),
                              minQuantity: wholesaleQtyController.text.toString(),
                              desc: descriptionController.text,
                              context: context
                            );
                            Get.back();
                          } : () async {
                            controller.isLoading(true);
                            await controller.uploadImage();
                            await controller.uploadProduct(
                              pName: productNameController.text,
                              mrp: mrpController.text.toString(),
                              wholesalePrice: wholesalePriceController.text.toString(),
                              minQuantity: wholesaleQtyController.text.toString(),
                              desc: descriptionController.text,
                              context: context
                            );
                            Get.back();
                          },
                      ),
                      36.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
