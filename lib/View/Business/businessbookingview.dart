import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:zulassung123/View/Components/CustomerList/customeritem.dart';
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';

// Page Title: MEINE BUCHUNGEN
// Trans: MY BOOKINGS

class BusinessBookingView extends StatefulWidget {
  final String email;
  BusinessBookingView(this.email);
  @override
  _BusinessBookingViewState createState() => _BusinessBookingViewState();
}

class _BusinessBookingViewState extends State<BusinessBookingView> {
  @override
  void initState(){
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
              leftW: PrevPageButton(context)
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTitleBar(sz, "MEINE BUCHUNGEN"),
              Expanded(
                child: StreamBuilder<Object>(
                  stream: firebaseController.GetAppointsData(widget.email),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData || snapshot.data == null) return Container();
                    List<AppointModel> appoints = snapshot.data;
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.03),
                          child:ListView.builder(
                            itemCount: appoints.length,
                            itemBuilder: (context, int idx) {
                              return CustomerItem(
                                context,
                                appoints[idx].name,
                                bookdate: ChangeDateFormat(appoints[idx].date) ,
                                annotation: appoints[idx].annotation,
                                isDel: true,
                                onTap: (){
                                  openMessageDialog(context, appoints[idx].id);
                                }
                              );
                            }
                          )
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openMessageDialog(context, String appointID) {
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
                                await firebaseController.deleteBusinessAppoint(appointID);
//                                await sqliteController.deleteData(telephone);
//                                await getAllList();
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
