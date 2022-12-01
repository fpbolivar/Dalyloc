import 'package:flutter/material.dart';

class CardBackLayout {
  String? cvv;
  double? width;
  double? height;
  Color? color;

  CardBackLayout({this.cvv, this.width, this.height, this.color});

  Widget layout1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.black,
          height: 25,
          width: width,
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                height: 25,
                color: Colors.grey,
              ),
            ),
            Flexible(
              child: SizedBox(
                height: 25,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    cvv.toString(),
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
