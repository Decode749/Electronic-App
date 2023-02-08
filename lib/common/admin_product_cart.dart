
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart_app/constants/consts.dart';

import '../controller/products_controller.dart';
import '../views/admin_screens/admin_nav_screens/admin_post_screen.dart';

class AdminProductCard extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;
  const AdminProductCard({Key? key, required this.data}) : super(key: key);

  @override
  State<AdminProductCard> createState() => _AdminProductCardState();
}

class _AdminProductCardState extends State<AdminProductCard> {
  var controller = Get.put(ProductsController());

  final popUpMenuUnavailable = ["Mark Unavailable", "Change Details"];

  final popUpMenuAvailable = ["Mark Available", "Change Details"];

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: shadowBlueColor,
              offset: Offset(0.0, 0.0),
              blurRadius: 4
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 74,
                width: 74,
                child: Image.network(
                  widget.data['photo_url'],
                  fit: BoxFit.fill,
                ),
              ),
              20.widthBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['p_name'],
                    style: const TextStyle(
                      fontFamily: "Lato",
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  6.heightBox,
                  Text(
                    "MRP: \$${widget.data['mrp']}",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      color: textDarkGreyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.heightBox,
                  Text(
                    "Wholesale Price: \$${widget.data['wholesale_price']}",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      color: textDarkGreyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.heightBox,
                  Text(
                    "Min Quantity: ${widget.data['min_quantity']}",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      color: textDarkGreyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // IconButton(
          //   onPressed: (){},
          //   icon: const Icon(Icons.more_vert, color: Colors.black,),
          // )
          VxPopupMenu(
            arrowSize: 0.0,
            menuBuilder: () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.unavailableProduct(available: widget.data['available'] ? false : true, context: context, pid: widget.data['pid']);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: widget.data['available'] ? const Text("Mark Unavailable") : const Text("Mark Available"),
                    ),
                  ),
                  const SizedBox(width: 124 ,child: Divider()),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AdminPostScreen(isEdit: true, data: widget.data));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text("Change Details"),
                    ),
                  ),
                ],
              ),
            ).onTap(() {
              VxPopupMenuController().hideMenu();
            }),
            clickType: VxClickType.singleClick,
            child: const Icon(Icons.more_vert, size: 26,),
          ),

          // PopupMenuButton<int>(
          //   itemBuilder: (context) => [
          //     // popupmenu item 1
          //     PopupMenuItem(
          //       value: 1,
          //       // row has two child icon and text.
          //       onTap: () async {
          //         await controller.unavailableProduct(available: data['available'] ? false : true, context: context, pid: data['pid']);
          //       },
          //       child:
          //       data['available'] ? const Text("Mark Unavailable") : const Text("Mark Available"),
          //     ),
          //     // popupmenu item 2
          //     PopupMenuItem(
          //       value: 2,
          //       onTap: () {
          //         Get.to(() => const AdminPostScreen());
          //       },
          //       // row has two child icon and text
          //       child:
          //       const Text("Change Details")
          //     ),
          //   ],
          //   offset: const Offset(0, 100),
          //   color: Colors.grey.shade100,
          //   elevation: 2,
          // ),
        ],
      ),
    );
  }
}
