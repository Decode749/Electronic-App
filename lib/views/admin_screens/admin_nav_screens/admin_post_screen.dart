import 'dart:io';

import 'package:mart_app/constants/consts.dart';

import '../../../controller/products_controller.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

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
                       const Expanded(child: Text(
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
                          child: controller.pImage != null ? Image.file(controller.pImage, fit: BoxFit.cover,) : Container(
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
                          btnText: "Add Product",
                          onTap: () async {
                            controller.isLoading(true);
                            await controller.uploadImage();
                            await controller.uploadProduct(
                              pName: productNameController.text,
                              mrp: mrpController.text,
                              wholesalePrice: wholesalePriceController.text,
                              minQuantity: wholesaleQtyController.text,
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
