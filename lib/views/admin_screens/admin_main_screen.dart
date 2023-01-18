import 'package:mart_app/constants/consts.dart';

import 'admin_nav_screens/admin_order_screen.dart';
import 'admin_nav_screens/admin_post_screen.dart';
import 'admin_nav_screens/admin_products_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  List pages = [
    const AdminProductsScreen(),
    const AdminPostScreen(),
    const AdminOrderScreen(),
  ];

  int currentIndex = 0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkBlue,
        unselectedItemColor: Colors.grey.shade400,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "Add Product"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_rounded), label: "Orders"),
        ],
      ),
    );
  }
}