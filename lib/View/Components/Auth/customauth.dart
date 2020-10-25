import 'package:flutter/material.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';

Widget CustomAuthTitle(title, smalltitle) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        AuthLargeText(title),
        AuthSmallText(smalltitle)
      ]
    ),
  );
}
Widget StandardCustormerButton(context, {String title, Function onTap}) {
  Size sz = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffededed),
          width: 2
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset("assets/StandardLoginPrefix.png", height: sz.height * 0.085,),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: BlackTextMD(title),
            ),
          )
        ],
      )
    ),
  );
}

Widget BusinessCustormerButton(context, {String title, Function onTap}) {

  return CustomJoinButton(context, title: title, onTap: onTap);
}

Widget AdminSingInButton(context, {String title, Function onTap}) {
  Size sz = MediaQuery.of(context).size;

  return Container(
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sz.width * 0.1, vertical: sz.height * 0.01),
          child: BlackTextMD(title),
        ),
      )
  );
}