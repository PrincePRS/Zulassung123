import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/View/Client/mybooking.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';
import 'package:zulassung123/View/authpage.dart';
import 'package:flutter/material.dart';
import 'package:zulassung123/globalinfo.dart';


Widget   BackgroundAppBar(BuildContext context, {leftW, centerW, rightW}){
  Size sz = MediaQuery.of(context).size;
  return PreferredSize(

    preferredSize: Size.fromHeight(60.0),

    child: AppBar(
      flexibleSpace: Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: Center(
              child: centerW == null ? Container() : centerW,
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: sz.width * 0.05),
            alignment: Alignment.centerRight,
            child:  rightW == null ? Container() : rightW,
          ),
          Container(
            padding: EdgeInsets.only(left: sz.width * 0.015),
            color: Colors.transparent,

            alignment: Alignment.centerLeft,
            child:  leftW == null ? Container() : leftW,
          ),
        ],
      ),
      leading: Container(
      ),
      elevation: 0,
      backgroundColor: Colors.red.withOpacity(0),
    ),
  );

}

Widget CustomAppBar1(BuildContext context, {leftW, centerW, rightW}){
  Size sz = MediaQuery.of(context).size;
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: AppBar(
      flexibleSpace: Stack(
        children: <Widget>[
          Container(
          //  padding: EdgeInsets.only(top: 15),
            child: Center(
              child: centerW == null ? Container() : centerW,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: sz.width * 0.015),
            alignment: Alignment.centerLeft,
            child:  leftW == null ? Container() : leftW,
          ),
          Container(
            padding: EdgeInsets.only(right: sz.width * 0.05),
            alignment: Alignment.centerRight,
            child:  rightW == null ? Container() : rightW,
          ),
        ],
      ),
      leading: Container(),
      backgroundColor: Color(0xffffffff),
    ),
  );
}

Widget logoIcon(){
  return Image.asset("assets/logo.png", height: 32,fit: BoxFit.cover,);
}

Widget CustomAppBar(BuildContext context, {Widget actWidget, Widget titleWidget, Widget leadWidget} ){
  Size sz = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: Padding(
      padding: EdgeInsets.only(left: sz.width * 0.04),
      child: Center(
          child: leadWidget != null ? leadWidget : Container(
            height: 35,
            child: Image.asset("assets/logo.png", fit: BoxFit.cover,),
          )
      ),
    ),
    centerTitle: true,
    title: titleWidget == null ? Text("") : titleWidget,
    actions: <Widget>[
      actWidget != null ? actWidget : Padding(
        padding: EdgeInsets.only(right: sz.width * 0.05),
        child: ProfileImage(context, 0.06),
      ),
    ],
  );
}

Widget PrevPageButton(BuildContext context, {Widget prevPage} ){
  return IconButton(
    onPressed: () {
      prevPage == null ?  Navigator.pop(context) : Navigator.push(context, MaterialPageRoute(builder: (context)=> prevPage));
    },
    icon: Icon(
      Icons.arrow_back,
      color: Colors.black,
    ),
    iconSize: 30,
  );
}

Widget DialogCloseButtton(BuildContext context){
  return                         Container(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: BlackTextMD("X"),
      ),
    ),
  );
}

Widget LogoutButton(BuildContext context){
  Size sz = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () async{
      AuthInfo auth = await sqliteController.getAuthInfo();
      AuthInfo authInfo = new AuthInfo(id: 1, role: -1, email: "", telephone: "", isRegister: auth.isRegister);
      await sqliteController.updateAuthInfo(authInfo);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthPage()));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: sz.height * 0.015, horizontal: sz.width * 0.03),
      child: Image.asset("assets/Logout.png"),
    ),
  );
}

Widget ProfileImage(BuildContext context, double rad, {Function onTap}){
  Size sz = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      radius: sz.width * rad,
      backgroundColor: ColorTheme.Red,
      child: ClipOval(
        child: SizedBox(
            width: sz.width * rad * 2,
            height: sz.width * rad * 2,
            child: Image.asset("assets/clock.png")
	      ),
      ),
    ),
  );
}

Widget PrintButton(BuildContext context, double rad, {Function onTap}){
  Size sz = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
      child: Image.asset("assets/cloudexpert.png"),
    ),
  );
//  return GestureDetector(
//    onTap: onTap,
//    child: CircleAvatar(
//      radius: sz.width * rad,
//      backgroundColor: ColorTheme.Grey,
//      child: ClipOval(
//        child: SizedBox(
//            width: sz.width * rad * 2,
//            height: sz.width * rad * 2,
//            child: Icon(Icons.local_printshop, size: 30, color: Colors.black,)
//        ),
//      ),
//    ),
//  );
}