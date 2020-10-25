import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';


Widget BlackTextSSBM(String text){
  return Text(text, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold,fontFamily: "Roboto-Bold"));
}

Widget BlackTextTiny(String text){
  return Text(text,  maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget BlackTextSM(String text){
  return Text(text, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget BlackTextMD(String text){
  return Text(text, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget BlackTextBG(String text){
  return Text(text, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget BlackTextLG(String text){
  return Text(text, style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}
Widget GreyTextSSM(String text){
  return Text(text, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Color(0xff797373), fontSize: 12, fontFamily: "Roboto-Bold"));
}
Widget GreyTextSM(String text){
  return Text(text, style: TextStyle(color: Color(0xff797373), fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget GreyTextMD(String text){
  return Text(text, style: TextStyle(color: Color(0xff797373), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}


Widget GreyTextBG(String text){
  return Text(text, style: TextStyle(color: Color(0xff797373), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}


Widget GreyTextLG(String text){
  return Text(text, style: TextStyle(color: Color(0xff797373), fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}



Widget WhiteTextSM(String text){
  return Text(text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget WhiteTextMD(String text){
  return Text(text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget WhiteTextBG(String text){
  return Text(text, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget WhiteTextLG(String text){
  return Text(text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}

Widget RedTextSM(String text){
  return Text(text, style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget RedTextMD(String text){
  return Text(text, style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget RedTextBG(String text){
  return Text(text, style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget RedTextLG(String text){
  return Text(text, style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}

Widget BlueTextTiny(String text){
  return Text(text, style: TextStyle(color: ColorTheme.Blue, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget BlueTextSM(String text){
  return Text(text, style: TextStyle(color: ColorTheme.Blue, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget BlueTextMD(String text){
  return Text(text, style: TextStyle(color: ColorTheme.Blue, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}


Widget BlueTextBG(String text){
  return Text(text, style: TextStyle(color: ColorTheme.Blue, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}


Widget BlueTextLG(String text){
  return Text(text, style: TextStyle(color: ColorTheme.Blue, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"));
}
Widget OrangeTextSM(String text){
  return Text(text, style: TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold"));
}

Widget AuthLargeText(String text){
  return Text(text, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color(0xFF014b78),  fontFamily: "LeagueSpartan"));
}
Widget AuthSmallText(String text){
  return Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,  fontFamily: "LeagueSpartan"));
}