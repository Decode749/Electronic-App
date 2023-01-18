import 'package:mart_app/constants/consts.dart';

class AddedWidget extends StatefulWidget {
  const AddedWidget({Key? key}) : super(key: key);

  @override
  State<AddedWidget> createState() => _AddedWidgetState();
}

class _AddedWidgetState extends State<AddedWidget> {

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainButton(
            btnText: "-",
            onTap: (){
              setState(() {
                if(counter > 0){
                  counter--;
                }
              });
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
              borderRadius: BorderRadius.circular(18)
            ),
            child: Center(
              child: Text(
                counter.toString(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            ),
          ),
        ),
        4.widthBox,
        MainButton(
          btnText: "+",
          onTap: (){
            setState(() {
              counter++;
            });
          },
          vertPadding: 8,
          horiPadding: 12,
          radius: 8,
        ),
      ],
    );
  }
}
