import 'package:flutter/material.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';

// Anmerkung: annotation
Widget CustomerItem(context, customername, {String bookdate, String annotation, Function onTap, bool isDel}) {
  Size sz = MediaQuery.of(context).size;
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.02),
      margin: EdgeInsets.symmetric(vertical: sz.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffe5ebed)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: sz.width * (onTap == null? 0.4: 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlackTextMD(customername),
                SizedBox(height: 5),
                GreyTextSSM(bookdate)
              ],
            ),
          ),
          Container(
            width: sz.width * (onTap == null? 0.4: 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlackTextMD("Anmerkung"),
                SizedBox(height: 5),
                GreyTextSSM(annotation)
              ],
            ),
          ),
          onTap != null ? GestureDetector(
            child: isDel == null ? OrangeTextSM('(i)') : Icon(Icons.cancel, color: Colors.red,) ,
            onTap: onTap,
          ):Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    ),
  );
}