import 'package:mart_app/constants/consts.dart';

import '../../../common/admin_product_cart.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({Key? key}) : super(key: key);

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  @override
  Widget build(BuildContext context) {

    final searchController = TextEditingController();

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
                        "Welcome Back",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      ),
                      GestureDetector(
                          onTap: (){},
                          child: const Icon(Icons.more_vert, color: Colors.white)),
                    ],
                  ),
                  8.heightBox,
                  const Text("Admin", style: TextStyle(
                    fontFamily: "Lato",
                    color: Colors.white,
                  ),),
                  16.heightBox,
                  CustomTextField(
                    controller: searchController,
                    hintText: "Search products...",
                    fillColor: Colors.white,
                    hintColor: textDarkGreyColor,
                    borderColor: Colors.white,
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
                      "Your Listed Products",
                      style: TextStyle(
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    16.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
                    12.heightBox,
                    const AdminProductCard(),
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
