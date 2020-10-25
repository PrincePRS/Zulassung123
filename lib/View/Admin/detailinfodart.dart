import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import '../Components/common/customappbar.dart';
import '../Components/common/custombuttons.dart';
import '../Components/common/custominput.dart';
import '../Components/common/customtexts.dart';

// KFZ
// Title: UNTERNEHMENSDATEN

class DetailInfo extends StatefulWidget {
  final String _name;
  final String _email;
  final String _telephone;
  DetailInfo(this._name, this._email, this._telephone);
  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String companyController = ''; // Unternehmen:
  String  ownerController = '';   // Ansprechpartner:
  String streetController = ''; // Straße:
  String placeController = '';  // Ort:

  String appointmentController = ''; // Terminbuchung:
  String emailController = ''; // E-Mail:
  String telephoneController = ''; // Telefonnummer:

  bool role;

  getdatas()async{
    if(widget._email != null){
      List<UserModel> users = await firebaseController.GetUserFutureData(widget._email);
      if(users.length == 1){
        setState(() {
          companyController = users[0].companyname;
          ownerController = users[0].contactpartner;
          streetController = users[0].streetname;
          placeController = users[0].place;
          appointmentController = users[0].postcode;
          emailController = widget._email;
          telephoneController = widget._telephone;
        });
        return;
      }
      setState(() {
        ownerController = widget._name;
        telephoneController = widget._telephone;
      });

    }

  }

  @override
  void initState() {
      getdatas();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar1(context,
            centerW: Container(
                padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
                child: Image.asset("assets/Logo.png")),
              leftW: PrevPageButton(context)
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTitleBar(sz, (widget._email == null || widget._email == '') ? "KUNDENDATEN" : "UNTERNEHMENSDATEN"),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: sz.width * 0.09, right: sz.width * 0.09, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        (widget._email == null || widget._email == '') ? Container() : CustomSelectableText(context, "Unternehmen:", companyController),
                        CustomSelectableText(context, "Ansprechpartner:", ownerController),
                        (widget._email == null || widget._email == '') ? Container() : CustomSelectableText(context, "Straße:", streetController),
                        (widget._email == null || widget._email == '') ? Container() : CustomSelectableText(context, "Ort:", placeController),
                        (widget._email == null || widget._email == '') ? Container() : CustomSelectableText(context, "PLZ:", appointmentController,  icon:Icon(Icons.date_range,color: Colors.orange)),
                        (widget._email == null || widget._email == '') ? Container() : CustomSelectableText(context, "E-Mail:", emailController,  icon:Icon(Icons.email,color: Colors.orange)),
                        CustomSelectableText(context, "Telefonnummer:", telephoneController, icon:Icon(Icons.call,color: Colors.orange))
                        //CustomTextField(telephoneController, inputLabelText: "Telefonnummer:", icon: Icon(Icons.call,color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
