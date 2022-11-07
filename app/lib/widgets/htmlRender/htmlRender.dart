import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_html/flutter_html.dart';

// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';

class HTMLRender extends StatelessWidget {
  var data_temp = "<p>No Data</p>";

  var data = "";
  Color? color;
  HTMLRender({this.data = "<p>No Data</p>", this.color});
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: data,

        //Optional parameters:
        style: {
          // 'body': Style(textAlign: TextAlign.left),

//         "html": Style(
//           backgroundColor: Colors.black12,
// //              color: Colors.white,
//         ),
          // "h1": Style(
          //   textAlign: TextAlign.center,
          // ),

          "a": Style(
              color: Colors.black,
              fontSize: FontSize.larger,
              fontWeight: FontWeight.w500,
              textDecoration: TextDecoration.none),
          // "tr": Style(
          //   border: Border(bottom: BorderSide(color: Colors.grey)),
          // ),
          // "img": Style(
          //     alignment: Alignment.center, padding: EdgeInsets.only(top: 20)),
          // "td": Style(
          //   padding: EdgeInsets.all(6),
          // ),
          "body": Style(
              fontFamily: 'NotoSans',
              fontSize: FontSize.small,
              color: color,
              alignment: Alignment.bottomLeft),
        },
        // customRender: {
        //   "flutter": (RenderContext context, Widget child) {
        //     return FlutterLogo(
        //       style: (context.tree.element!.attributes['horizontal'] != null)
        //           ? FlutterLogoStyle.horizontal
        //           : FlutterLogoStyle.markOnly,
        //       textColor: context.style.color!,
        //       size: context.style.fontSize!.size! * 5,
        //     );
        //   },
        // },
        onLinkTap: (url, _, __, ___) {
          print("Opening $url...");
        },
        onImageTap: (src, _, __, ___) {
          print(src);
        },
        onImageError: (exception, stackTrace) {
          print(exception);
        },
      ),
    );
  }
}
