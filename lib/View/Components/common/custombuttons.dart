import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';

import 'customtexts.dart';

// Als Händler registrieren
Widget CustomJoinButton(context, {String title, Function onTap}) {
  Size sz = MediaQuery.of(context).size;

  return RaisedButton(
    color: Colors.orange,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: sz.height * 0.020),
      child: WhiteTextMD(title), // Register as dealer
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    onPressed: onTap
  );
}

Widget CustomTitleBar(Size sz, String txt){
  return Container(
    padding: EdgeInsets.only(left: sz.width * 0.05, top: sz.height * 0.01, bottom: sz.height * 0.01),
    color: ColorTheme.Blue,
    child: WhiteTextSM(txt),
  );
}