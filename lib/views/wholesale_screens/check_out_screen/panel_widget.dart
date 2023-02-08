import 'package:mart_app/constants/consts.dart';
import 'package:mart_app/controller/profile_controller.dart';
import 'package:mart_app/views/wholesale_screens/cart_screen/cart_screen.dart';
import 'package:mart_app/views/wholesale_screens/check_out_screen/check_out_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatefulWidget {

  final ScrollController controller;

  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  final houseNumController = TextEditingController();

  final streetController = TextEditingController();

  final localityController = TextEditingController();

  final landmarkController = TextEditingController();

  final cityController = TextEditingController();

  final stateController = TextEditingController();

  final pincodeController = TextEditingController();

  final contactController = TextEditingController();


  var controller = Get.put(ProfileController());

  @override
  void dispose() {
    super.dispose();

    houseNumController.dispose();
    streetController.dispose();
    localityController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    contactController.dispose();
  }

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              color: darkGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0,
                    0.5,
                  ),
                  blurRadius: 1,
                  spreadRadius: 0,
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.heightBox,
              GestureDetector(
                onTap: (){
                  togglePanel();
                },
                child: Container(
                  height: 6,
                  width: 32,
                  decoration: BoxDecoration(
                    color: textDarkGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              16.heightBox,
              const Text(
                "Add New Address",
                style: TextStyle(
                  fontFamily: "Lato",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              12.heightBox,
            ],
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          controller: widget.controller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            // content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.heightBox,
                  CustomTextField(
                    controller: houseNumController,
                    hintText: "House/Apartment Number",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: streetController,
                    hintText: "Street",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: localityController,
                    hintText: "Locality",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: landmarkController,
                    hintText: "Landmark (optional)",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: cityController,
                    hintText: "City",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: stateController,
                    hintText: "State",
                    fillColor: Colors.white,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: pincodeController,
                    hintText: "Pin Code",
                    fillColor: Colors.white,
                    keyboardType: TextInputType.number,
                  ),
                  6.heightBox,
                  CustomTextField(
                    controller: contactController,
                    hintText: "Contact Number",
                    fillColor: Colors.white,
                    keyboardType: TextInputType.phone,
                  ),
                  12.heightBox,
                  MainButton(
                    btnText: "Add Address",
                    onTap: () async {
                      if( houseNumController.text.isEmpty ||
                          streetController.text.isEmpty ||
                          localityController.text.isEmpty ||
                          cityController.text.isEmpty ||
                          stateController.text.isEmpty ||
                          pincodeController.text.isEmpty ||
                          contactController.text.isEmpty
                      ){
                        showSnackBar("Enter all the fields", context);
                      } else {
                        await controller.addAddress(
                          houseNo: houseNumController.text,
                          streetNo: streetController.text,
                          locality: localityController.text,
                          landmark: landmarkController.text,
                          city: cityController.text,
                          state: stateController.text,
                          pincode: pincodeController.text.toString(),
                          contactNo: contactController.text.toString(),
                        );
                        widget.panelController.close();
                        Get.off(() => const CartScreen());
                        showSnackBar("Address added successfully", context);
                      }

                    },
                  ),
                  36.heightBox,
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
