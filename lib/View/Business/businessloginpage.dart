import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Provider/authprovider.dart';
import 'package:zulassung123/View/Admin/adminbookpage.dart';
import 'package:zulassung123/View/Business/businessbookpage.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:zulassung123/View/Components/common/custominput.dart';
import 'package:provider/provider.dart';
import '../Components/Auth/customauth.dart';
import '../Components/common/custombuttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BusinessLoginPage extends StatefulWidget {
  @override
  _BusinessLoginPageState createState() => _BusinessLoginPageState();
}

class _BusinessLoginPageState extends State<BusinessLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController(); // Firmenname*:
  final passwordController = TextEditingController();   // Telefon*

  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    emailController.text = "";
    passwordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                Image.asset('assets/adminlogin.png', fit: BoxFit.fitWidth,),
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                        height: sz.height * 0.5,
                        margin: EdgeInsets.only(
                          top: sz.height * 0.03,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: sz.width * 0.1, right: sz.width * 0.1, top: sz.height * 0.1),
                          child: Image.asset("assets/Logo.png"),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CustomTitleTextField(emailController, inputLabelText: "E-Mail*", formType: 2, keyType: 2),
                              CustomTitleTextField(passwordController, inputLabelText: "Password*", formType: 1, secureType: 1),
                              SizedBox(height: 15,),
                              isLoading ? Center(child: CircularProgressIndicator()) : CustomJoinButton(context, title: "Login", onTap:() async{
                                final formstate = _formKey.currentState;
                                try{
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if(_formKey.currentState.validate() != true) {
                                    setState(() {isLoading = false;});
                                    return;
                                  }
                                  List<UserModel> admins = await firebaseController.GetUserFutureData(emailController.text);
                                  print(admins[0].roleid);
                                  if(admins.length != 1 || admins[0].roleid != '1') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }

                                  print(admins.length.toString() + '---');
                                  final AuthResult auth =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                  FirebaseUser user = auth.user;
                                  formstate.save();

                                  Provider.of<AuthProvider>(context, listen: false).UpdateRole(1);
                                  AuthInfo authInfo = new AuthInfo(id: 1, role: 1, email: emailController.text, telephone: passwordController.text, isRegister: 1);
                                  await sqliteController.updateAuthInfo(authInfo);
                                  AuthInfo p = await sqliteController.getAuthInfo();
                                  print(p.toString());
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessBookPage(admins[0])));
                                }catch(e){

                                  setState(() {
                                    isLoading = false;
                                  });
                                  //final snacBar = SnackBar(content: Text(e.toString()));
                                  //Scaffold.of(context).showSnackBar(snacBar);
                                }
                              })
                            ]
                        ),
                      ),
                    )
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
