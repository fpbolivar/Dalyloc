import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class CustomTF extends StatefulWidget {
  // double width = 100;
  double height = 50;
  var controllr = TextEditingController();
  String placeholder = "";

  //Color background;
  // Color titleColor;
  bool obscureText;
  bool enabled;
  bool password;

  TextInputType keyBoardType;
  Function(String)? onChange;
  CustomTF(
      {this.password = false,
      //this.width = double.infinity,
      required this.controllr,
      this.keyBoardType = TextInputType.text,
      this.height = 50,
      this.placeholder = "",
      // this.background,
      // this.titleColor,
      this.obscureText = false,
      this.enabled = true,
      this.onChange});

  @override
  State<CustomTF> createState() => _CustomTFState();
}

class _CustomTFState extends State<CustomTF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.textBlackColor
              //                   <--- border width here
              ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: TextField(
          controller: widget.controllr,
          style: TextStyle(fontSize: 16),
          onChanged: (text) => {widget.onChange!(text)},
          keyboardType: widget.keyBoardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.placeholder,
            suffixIcon: widget.password == true
                ? IconButton(
                    onPressed: () {
                      //add Icon button at end of TextField
                      setState(() {
                        //refresh UI
                        if (widget.obscureText) {
                          //if passenable == true, make it false
                          widget.obscureText = false;
                        } else {
                          widget.obscureText =
                              true; //if passenable == false, make it true
                        }
                      });
                    },
                    icon: Icon(
                      widget.obscureText == true
                          ? Icons.remove_red_eye
                          : Icons.password,
                      // color: Colors.black,
                    ),
                  )
                : null,
          ),
          autofocus: false,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
        ),
      ),
    );
  }
}
