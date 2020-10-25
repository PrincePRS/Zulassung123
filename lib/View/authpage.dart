import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Provider/authprovider.dart';
import 'package:zulassung123/Provider/clientprovider.dart';
import 'package:zulassung123/View/Admin/adminbookpage.dart';
import 'package:zulassung123/View/Business/businessbookpage.dart';
import 'package:zulassung123/View/Business/businessloginpage.dart';
import 'package:zulassung123/View/Client/clientbookpage.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:zulassung123/View/Admin/adminloginpage.dart';
import 'package:zulassung123/View/Business/businessjoinpage.dart';
import 'package:provider/provider.dart';
import 'Components/Auth/customauth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/KFZ_Login.png', fit: BoxFit.fitWidth,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(left: sz.width * 0.1, right: sz.width * 0.1, top: sz.height * 0.13),
                  child: Image.asset("assets/Logo.png")
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    StandardCustormerButton(context, title: "Als Kunde Termin buchen", onTap:() async{
                      Provider.of<AuthProvider>(context, listen: false).UpdateRole(-1);
                      await Provider.of<ClientProvider>(context, listen: false).UpdateAppoints(DateTime.now().year, DateTime.now().month);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClientBookPage()));
                    }),
                    BusinessCustormerButton(context, title: "Als Händler registrieren", onTap: () async{
                      AuthInfo authInfo = await sqliteController.getAuthInfo();
                      if(authInfo.role != 1){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessJoin()));
//                          if(authInfo.isRegister == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessJoin()));
//                          else Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessLoginPage()));
                        return;
                      }
                      Provider.of<AuthProvider>(context, listen: false).UpdateRole(1);
                      List<UserModel> users = await firebaseController.GetUserFutureData(authInfo.email);
                      if(users == null || users.length == 0) return;
                      Provider.of<AuthProvider>(context, listen: false).UpdateUser(users[0]);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessBookPage(users[0])));
                    }),
                    SizedBox(height: sz.height * 0.02),
                    AdminSingInButton(context, title: "Einloggen", onTap: () async{
                      AuthInfo authInfo = await sqliteController.getAuthInfo();
                      if(authInfo.role == -1){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
                      }else if(authInfo.role == 0){
                       // Provider.of<AuthProvider>(context, listen: false).UpdateRole(0);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminBookPage()));
                      }else if(authInfo.role == 1){
                       // Provider.of<AuthProvider>(context, listen: false).UpdateRole(1);
                        List<UserModel> users = await firebaseController.GetUserFutureData(authInfo.email);
                        if(users == null || users.length == 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
                        }else{
                          Provider.of<AuthProvider>(context, listen: false).UpdateUser(users[0]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessBookPage(users[0])));
                        }
                      }
                    }),
                    SizedBox(height: sz.height * 0.03,)
                  ]
                ),
              )
            ],
          ),
        ]
      ),
    );
  }
}
