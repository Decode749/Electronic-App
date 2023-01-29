import 'package:mart_app/constants/consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../common/admin_order_card.dart';
import '../order_panel.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        minHeight: 0.0,
        maxHeight: MediaQuery.of(context).size.height*0.76,
        panelBuilder: (controller) => OrderPanelWidget(
          panelController: panelController,
          controller: controller,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
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
                          "Orders",
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
                        "Pending Orders",
                        style: TextStyle(
                            fontFamily: "Lato",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      16.heightBox,
                      AdminOrderCard(
                        onViewTap: (){
                          panelController.open();
                        },
                      ),
                      36.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
