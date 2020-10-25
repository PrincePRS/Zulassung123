import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Provider/authprovider.dart';
import 'package:zulassung123/View/Business/businessbookpage.dart';
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';
import 'package:zulassung123/View/Admin/adminbookpage.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zulassung123/View/Components/common/custominput.dart';
import 'package:provider/provider.dart';
import '../Components/common/custombuttons.dart';
import '../Components/common/customtexts.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Page Title: Die unkomplizierte Terminbuchung.
// trans: The uncomplicated appointment booking.

class BusinessJoin extends StatefulWidget {
  @override
  _BusinessJoinState createState() => _BusinessJoinState();
}

class _BusinessJoinState extends State<BusinessJoin> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final companyNameController = TextEditingController(); // Firmenname*:
  final contactPartnerController = TextEditingController();   // Ansprechptartner
  final streetNameController = TextEditingController(); // Straßenname
  final postCodeController = TextEditingController();  // PLZ
  final placeController = TextEditingController(); // Ort
  final emailController = TextEditingController(); // E-Mail*
  final telephoneController = TextEditingController(); // Telefon*
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    isLoading = false;
    companyNameController.text = "";
    contactPartnerController.text = "";
    streetNameController.text = "";
    postCodeController.text = "";
    placeController.text = "";
    emailController.text = "";
    passwordController.text="";
    telephoneController.text = "";

  }
  @override
  void dispose() {
    companyNameController.dispose();
    contactPartnerController.dispose();
    streetNameController.dispose();
    postCodeController.dispose();
    placeController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  singUpwithBusinessInfo() async{
    setState(() {isLoading = true;});
    final formstate = _formKey.currentState;
    if(_formKey.currentState.validate() != true) {
      setState(() {isLoading = false;});
      return;
    }
    try{
      final AuthResult auth =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      FirebaseUser user = auth.user;

      formstate.save();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{


        UserModel userdata = new UserModel(
            id : null,
            companyname : companyNameController.text,
            contactpartner : contactPartnerController.text,
            streetname : streetNameController.text,
            postcode : postCodeController.text,
            place : placeController.text,
            email : emailController.text,
            telephone : telephoneController.text,
            roleid : "1",
        );
        await firebaseController.insertUser(userdata);
        Provider.of<AuthProvider>(context, listen: false).UpdateRole(1);
        AuthInfo authInfo = new AuthInfo(id: 1, role: 1, email: emailController.text, telephone: telephoneController.text, isRegister: 1);
        await sqliteController.updateAuthInfo(authInfo);
       // authInfo = await sqliteController.getAuthInfo();
       // print(authInfo.toString());
        Provider.of<AuthProvider>(context, listen: false).UpdateUser(userdata);
        setState(() {isLoading = false;});
        Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessBookPage(userdata)));
      });
    }catch(e){
      setState(() {isLoading = false;});
      //final snacBar = SnackBar(content: Text(e.toString()));
      //Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    Size sz = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
            child: Column(
              children: <Widget>[
                Image.asset(
          "assets/register.png",
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
                Expanded(child: Container(color: Colors.white,))
              ],
            )),
        Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: BackgroundAppBar(context,
            centerW: Container(
                padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
                child: Image.asset("assets/Logo.png")),
            leftW: PrevPageButton(context)
        ),
          body: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,

                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: sz.height * 0.03, horizontal: sz.width * 0.05),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CustomTitleTextField(companyNameController, inputLabelText: "Firmenname*", formType: 1),
                        CustomTitleTextField(contactPartnerController, inputLabelText: "Ansprechptartner"),
                        CustomTitleTextField(streetNameController, inputLabelText: "Straßenname u. Nmr."),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(width: sz.width * 0.3,child: CustomTitleTextField(postCodeController, inputLabelText: "PLZ")),
                            Container(width: sz.width * 0.5, child: CustomTitleTextField(placeController, inputLabelText: "Ort")),
                          ],
                        ),
                        CustomTitleTextField(emailController, inputLabelText: "E-Mail*", formType: 2, keyType: 2),
                        CustomTitleTextField(passwordController, inputLabelText: "Password*", formType: 1, secureType: 1),
                        CustomTitleTextField(telephoneController, inputLabelText: "Telefon*", formType: 1, keyType: 1),

                        Container( // Register Button
                          margin: EdgeInsets.only(top: 20),
                          child: isLoading ?  Center(child: CircularProgressIndicator()) : CustomJoinButton(context, title: "Als Händler registrieren", onTap: singUpwithBusinessInfo)
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        ),
      ],
    );
  }
}
