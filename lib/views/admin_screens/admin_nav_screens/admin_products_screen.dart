import 'package:mart_app/constants/consts.dart';

import '../../../common/admin_product_cart.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({Key? key}) : super(key: key);

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {

  final searchController = TextEditingController();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(child: Text(
                        "Your Products",
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
