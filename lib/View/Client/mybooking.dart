import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';

import '../Components/CustomerList/customeritem.dart';
import '../Components/common/customappbar.dart';
import '../Components/common/customtexts.dart';
import 'clientbookpage.dart';

// Page Title: MEINE BUCHUNGEN
// Trans: MY BOOKINGS

class MyBooking extends StatefulWidget {
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  List<String> customNameLists = <String>["ABCsss", "PPP"];
  List<String> customDatenLists = <String>["02.03.2020", "12.04.2020"];
  List<String> customAnnotationLists = <String>["Keine Anmerkung vorhanden", "Keine Anmerkung"];
  List<StandardUser> appoints = [];

  getAllList() async{
    List<StandardUser> temp = await sqliteController.getLists();
    setState(() {
      print("**" + temp.length.toString());
      appoints = temp;
    });
  }

  @override
  void initState(){
    getAllList();
    // TODO: implement initState
    super.initState();
  }

  String ChangeDateFormat(String date){
    List<String> splits = date.split('.');
    return splits[1] + "." + splits[0] + "." + splits[2];
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
              leftW: PrevPageButton(context, prevPage: ClientBookPage())
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTitleBar(sz, "MEINE BUCHUNGEN"),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.03),
                      child:ListView.builder(
                        itemCount: appoints.length,
                        itemBuilder: (context, int idx) {
                          return CustomerItem(
                            context,
                            appoints[idx].name,
                            bookdate: ChangeDateFormat(appoints[idx].date) ,
                            annotation: appoints[idx].annotation,
                            onTap: () {
                              openMessageDialog(context, appoints[idx].telephone);

                            },
                            isDel: true
                          );
                        }
                      )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openMessageDialog(context, String telephone) {
    Size sz = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: sz.height * 0.2,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Möchten Sie diesen Auftrag wirklich stornieren?',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: sz.height * 0.04
                      ),
                      ButtonTheme(
                          minWidth: sz.width * 0.2,
                          child: RaisedButton(
                              onPressed: () async {
                                await firebaseController.deleteCutomerAppoint(telephone);
                                await sqliteController.deleteData(telephone);
                                await getAllList();
                                Navigator.pop(c);
                              },
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              ),
                              child: Text(
                                'Stornieren',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          )
                      )
                    ],
                  )
              ),
            ),
          );
        }
    );
  }
}
