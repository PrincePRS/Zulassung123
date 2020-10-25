import 'package:flutter/material.dart';

import 'customtexts.dart';

Widget CustomTextField(TextEditingController controller, {String validateText,String inputLabelText, Icon icon,int formType}){
  // formType: 0 - normal, 1 - empty, 2 - email
  return Container(
    padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
    child: TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
      controller: controller,
      cursorColor: Colors.black,
      obscureText: formType == 1 ? true : false,
      decoration: new InputDecoration(
        icon: icon,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF014b78)),
        ),
        contentPadding:EdgeInsets.only(left: 0, bottom: 0, top: 00, right: 0),
        labelText: inputLabelText,
        labelStyle: TextStyle(color: Colors.grey),
      ),
      onSaved: (String value) {},
      validator: (value){
        if(formType == 0) return null;
        if(value.isEmpty) {
          if(formType == 1) return "Please fill this field";
          if(formType == 2) return "Please Insert Email";
        }
        if(formType == 2 && value.contains('@') == false) {
          return 'Your email is invalid';
        }
        return null;
        return null;
      },
    ),
  );
}

Widget CustomTitleTextField(TextEditingController controller, {String validateText, String inputLabelText,int formType, int keyType, int secureType}){
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 2, bottom: 5),
            child: BlackTextSSBM(inputLabelText)
        ),
        TextFormField(
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyType == null ? TextInputType.text : (keyType == 1 ? TextInputType.phone : TextInputType.emailAddress),
          obscureText: secureType == 1 ? true : false,
          decoration: new InputDecoration(
//            border: InputBorder.none,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 10.0,
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 10.0,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 10.0,
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
            fillColor: Color(0xffededed),
            filled: true,
          ),
          onSaved: (String value) {},
          validator: (value){
            if(formType == 0) return null;
            if(value.isEmpty) {
              if(formType == 1) return "Benötigt";
              if(formType == 2) return "Benötigt";
            }
            if(formType == 2 && value.contains('@') == false) {
              return 'Benötigt';
            }
            return null;
          },
        ),
      ]
    ),
  );
}

Widget CustomTitleTextArea(TextEditingController controller, {String validateText, String inputLabelText,int formType}){
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 5),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 2, bottom: 5),
              child: BlackTextSSBM(inputLabelText)
          ),
          TextFormField(
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            minLines: 3,
            maxLines: 10,
            controller: controller,
            cursorColor: Colors.black,
            obscureText: formType == 1 ? true : false,
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 10.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 10.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 10.0,
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
              fillColor: Color(0xffededed),
              filled: true,
            ),
            onSaved: (String value) {},

          ),
        ]
    ),
  );
}

Widget CustomSelectableText(BuildContext context, String headT, String contextT, {Icon icon}){
  Size sz = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      icon == null ? Container() : icon,
      icon == null ? Container() : Container(width: sz.width * 0.05),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
              child: Text(headT, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold")),
            ),
            SelectableText(contextT,  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Roboto-Bold")),
            Divider(color: Colors.black,)
          ],
        ),
      )
    ],
  );
}


