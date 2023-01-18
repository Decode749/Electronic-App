import 'package:mart_app/constants/consts.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {

  final productNameController = TextEditingController();
  final retailPriceController = TextEditingController();
  final wholesalePriceController = TextEditingController();
  final wholesaleQtyController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    productNameController.dispose();
    retailPriceController.dispose();
    wholesalePriceController.dispose();
    wholesaleQtyController.dispose();
    descriptionController.dispose();
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
                    children: const [
                       Expanded(child: Text(
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

                  16.heightBox,
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.heightBox,
                    const Text(
                      "List a product",
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    16.heightBox,
                    AspectRatio(
                        aspectRatio: 1/1,
                      child: Container(
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
                      controller: retailPriceController,
                      hintText: "Retail Price",
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
                      maxLines: 4,
                    ),
                    20.heightBox,
                    MainButton(
                        btnText: "Add Product",
                        onTap: (){},
                    ),
                    36.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
