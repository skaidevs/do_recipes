import 'package:dorecipes/widgets/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class HtmlViewer extends StatelessWidget {
  final String data;

  const HtmlViewer({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: data,

        //Optional parameters:
        style: {
          "html": Style(fontSize: FontSize(18.0), fontFamily: kBalooTamma2

              //backgroundColor: Colors.black12,
//                        color: Colors.white,
              ),
          "h1": Style(
            textAlign: TextAlign.center,
          ),
          "li": Style(
            fontFamily: kBalooTamma2,
            fontSize: FontSize(18.0),
          ),
          "table": Style(
            backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          ),
          "tr": Style(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          "th": Style(
            padding: EdgeInsets.all(6),
            backgroundColor: Colors.grey,
          ),
          "td": Style(
            padding: EdgeInsets.all(6),
          ),
          "var": Style(fontFamily: 'serif'),
        },

        /* customRender: {
          "flutter": (RenderContext context, Widget child, attributes, _) {
            return FlutterLogo(
              style: (attributes['horizontal'] != null)
                  ? FlutterLogoStyle.horizontal
                  : FlutterLogoStyle.markOnly,
              textColor: context.style.color,
              size: context.style.fontSize.size * 5,
            );
          },
        },*/
        /*customTextStyle: (Node node, TextStyle baseStyle) {
          return baseStyle.merge(TextStyle(height: 2, fontSize: 28));
        },*/
        onLinkTap: (url) {
          print("Opening $url...");
        },
        onImageTap: (src) {
          print(src);
        },
        onImageError: (exception, stackTrace) {
          print(exception);
        },
      ),
    );
  }
}
