import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:zulassung123/Provider/clientprovider.dart';
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/View/Components/common/custominput.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';
import 'package:zulassung123/View/Admin/detailinfodart.dart';
import 'package:zulassung123/View/Client/mybooking.dart';
import 'package:zulassung123/View/authpage.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:provider/provider.dart';

class ClientBookPage extends StatefulWidget {
  @override
  _ClientBookPageState createState() => _ClientBookPageState();
}

class _ClientBookPageState extends State<ClientBookPage> {
  static List<String> months = ['Januar','Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'];
  List<int> days = [];
  List<String> years=[];
  var dateUtility = new DateUtil();
  bool monthChange = false;
  bool yearChange = false;
  int month;
  int year;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  makedatestring(int yy, int mm, int dd){
    if(dd == -1) return "*";
    String m = mm < 10 ? "0" + mm.toString() : mm.toString();
    String d = dd < 10 ? "0" + dd.toString() : dd.toString();
    return m + "." + d + "." + yy.toString();
  }

  SetCalendar(){
    print(month.toString());
    print(year.toString());
    int numberofdays = dateUtility.daysInMonth(month, year);
    print("--->"  + numberofdays.toString());
    int weekdayOfFirstDay = DateTime(year, month, 1).weekday;
    print("==> " + weekdayOfFirstDay.toString());
    int numberOfDaysPrevMonth = month == 1 ? 31 : dateUtility.daysInMonth(month - 1, year);
    print("+++>" + numberOfDaysPrevMonth.toString());
    days.clear();
    setState(() {
      for(int i = 0; i < 42; i ++){
        if(i >= weekdayOfFirstDay - 1 && i < weekdayOfFirstDay + numberofdays - 1){
          days.add(i - weekdayOfFirstDay + 2);
        }else days.add(-1);
      }
    });
  }

  @override
  void initState() {
    for(int i = 1990; i <2050; i ++) {
      years.add(i.toString());
    }
    setState(() {
      month = DateTime.now().month;
      year = DateTime.now().year;
    });

    SetCalendar();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await Provider.of<ClientProvider>(context, listen: false).UpdateAppoints(year, month);
    });
//    for(int i = 0; i < 35; i ++) print(i.toString() + " | " + days[i].toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;

    return Container(
      color: Colors.white10,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar1(context,
            leftW: PrevPageButton(context, prevPage: AuthPage()),
            centerW: Container(
              padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
                child: Image.asset("assets/Logo.png")),
            rightW: ProfileImage(context, 0.045,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyBooking()));
              }
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTitleBar(sz, "TERMINBUCHUNG"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          yearChange = false;
                          monthChange = !monthChange;
                        });
                      },
                      child: Container(
                        width: sz.width * 0.5,
                        height: sz.height * 0.07,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                            )
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(monthChange ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 35),
                            SizedBox(width: sz.width * 0.05),
                            BlackTextMD(months[month - 1])
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          monthChange = false;
                          yearChange = !yearChange;
                        });
                      },
                      child: Container(
                        width: sz.width * 0.5,
                        height: sz.height * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                  width: 0,
                                )
                            )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(yearChange ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 35),
                            SizedBox(width: sz.width * 0.05),
                            BlackTextMD(year.toString())
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      height: sz.height * 0.7,
                      color: Colors.white10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: sz.height * 0.7,
                            child: Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              defaultColumnWidth: IntrinsicColumnWidth(),
                              columnWidths: {
                               // 0:FractionColumnWidth(.2)
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: ColorTheme.Blue,
                                  ),
                                  children: [
                                    CalendarWeekDayCell(sz, "MON"),
                                    CalendarWeekDayCell(sz, "DI"),
                                    CalendarWeekDayCell(sz, "MI"),
                                    CalendarWeekDayCell(sz, "DO"),
                                    CalendarWeekDayCell(sz, "FR"),
                                    CalendarWeekDayCell(sz, "SA"),
                                    CalendarWeekDayCell(sz, "SO"),
                                  ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){

                                      return CalendarDayCell(context, days[index].toString(), (days[index] != -1 && Provider.of<ClientProvider>(context).appoints[days[index]]), makedatestring(year, month, days[index]));
                                    })
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){

                                      return CalendarDayCell(context, days[index + 7].toString(), (days[index + 7] != -1 && Provider.of<ClientProvider>(context).appoints[days[index + 7]]), makedatestring(year, month, days[index + 7]));
                                    })
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){
                                      return CalendarDayCell(context, days[index + 14].toString(), (days[index + 14] != -1 && Provider.of<ClientProvider>(context).appoints[days[index + 14]]), makedatestring(year, month, days[index + 14]));
                                    })
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){
                                      return CalendarDayCell(context, days[index + 21].toString(), (days[index + 21] != -1 && Provider.of<ClientProvider>(context).appoints[days[index + 21]]), makedatestring(year, month, days[index + 21]));
                                    })
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){
                                      return CalendarDayCell(context, days[index + 28].toString(), (days[index + 28] != -1 && Provider.of<ClientProvider>(context).appoints[days[index + 28]]), makedatestring(year, month, days[index + 28]));
                                    })
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorTheme.Grey,
                                    ),
                                    children: List.generate(7, (index){
                                      return CalendarDayCell(context, days[index + 35].toString(), (days[index + 35] != -1 && Provider.of<ClientProvider>(context).appoints[days[index + 35]]), makedatestring(year, month, days[index + 35]));
                                    })
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                    monthChange ? Positioned(
                      top: 0,
                      left: sz.width * 0.05,
                      child: SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                          ),
                          elevation: 5.0,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.015),
                            height:sz.height * 0.5,
                            width: sz.width * 0.3,
                            child: ListView.builder(
                                itemCount: months.length,
                                itemBuilder: (context, int idx) {
                                  return GestureDetector(
                                    onTap: () async{
                                      setState(() {
                                        month = idx + 1;
                                      });
                                      await Provider.of<ClientProvider>(context, listen: false).UpdateAppoints(year, month);
                                      SetCalendar();
                                      monthChange = false;
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: sz.width * 0.03, vertical: sz.height * 0.015),
                                      //child: Text(months[idx], style: TextStyle(fontSize: 20)),
                                      child: BlackTextMD(months[idx]),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      )
                    ) : Container(),
                    yearChange ? Positioned(
                        top: 0,
                        left: sz.width * 0.55,
                        child: SingleChildScrollView(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight:  Radius.circular(10))
                            ),
                            elevation: 5.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: sz.width * 0.05),
                              height:sz.height * 0.5,
                              width: sz.width * 0.3,
                              child: ListView.builder(
                                  itemCount: years.length,
                                  itemBuilder: (context, int idx) {
                                    return GestureDetector(
                                      onTap: ()async{
                                        year = int.parse(years[idx]);
                                        await Provider.of<ClientProvider>(context, listen: false).UpdateAppoints(year, month);
                                        SetCalendar();
                                        yearChange = false;
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: sz.width * 0.03, vertical: sz.height * 0.015),
                                        //child: Text(years[idx], style: TextStyle(fontSize: 20)),
                                        child: BlackTextMD(years[idx]),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ),
                        )
                    ) : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

void openMessageDialog(BuildContext context, String date) {
  Size sz = MediaQuery.of(context).size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _annotationController = TextEditingController();
  showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.05),
            height: sz.height * 0.9,
            width: sz.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DialogCloseButtton(c),
                    Center(child: BlackTextLG("Terminbuchung")),
                    SizedBox(height: sz.height * 0.01),
                    Center(
                      child: Text("Hier hast Du die Möglichkeit deinen Termin bei uns einzubuchen. Bitte teile uns Namen und Telefonnumer mit, damit wir dich erreichen können.",
                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.normal,fontFamily: "Roboto-Bold"), textAlign: TextAlign.center,),
                    ),
//                    Center(
//                      child: Text("einzubuchen. Bitte teile uns Namen und Telefonnumer",
//                        style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.normal,fontFamily: "Roboto-Bold")),
//                    ),
//                    Center(
//                      child: Text("mit, damit wir dich erreichen können.",
//                        style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.normal,fontFamily: "Roboto-Bold")),
//                    ),
                    SizedBox(height: sz.height * 0.01,),
                    CustomTitleTextField(_nameController, inputLabelText: "Name*", formType: 1),
                    CustomTitleTextField(_phoneController, inputLabelText: "Telefonnummer*", formType: 1, keyType: 1),
                    CustomTitleTextArea(_annotationController, inputLabelText: "Ammerkungen"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.02),
                      child: CustomJoinButton(c, title: "Termin einbuchen", onTap: () async{
                          if(_formKey.currentState.validate() != true) {
                            return;
                          }
                          try{
                            AppointModel appoint = new AppointModel(
                                id: null,
                                date: date,
                                name: _nameController.text,
                                telephone: _phoneController.text,
                                annotation: _annotationController.text,
                                email: null
                            );
                            print(appoint.toString());
                            await firebaseController.insertAppoint(appoint);
                            StandardUser data = new StandardUser(
                                id: null,
                                date: date,
                                name: _nameController.text,
                                telephone: _phoneController.text,
                                annotation: _annotationController.text
                            );
                            print(data.toString());
                            await sqliteController.insertData(data);
                            List<String> split = date.split('.');
                            print(split[2] + "  |  " + split[0]);
                            Provider.of<ClientProvider>(context, listen: false).UpdateAppoints(int.parse(split[2]), int.parse(split[0]));
                            Navigator.pop(c);
                          }catch(e){

                          }
                        }
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        );
      }
  );
}

Widget CalendarDayCell(BuildContext context, String txt, bool booked, String date){
  Size sz = MediaQuery.of(context).size;
  return TableCell(child: Padding(
    padding: EdgeInsets.only(top: sz.height * 0.01, bottom: sz.height * 0.01),
    child: GestureDetector(
      onTap: (){
        if(booked || date=="*") return;
        openMessageDialog(context, date);
      },
      child: Column(
        children: <Widget>[
          CircleBtnWithBorderColor(
            child: Text(txt, style: TextStyle(color: txt == "-1" ? Colors.transparent : Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan")),
              fillcolor: booked ? ColorTheme.Orange : ColorTheme.Grey// ColorTheme.Orange
          ),
          Container(child: Center(
              child: Text("Dein Termin", style: TextStyle(color: booked ? Colors.black : Colors.transparent, fontSize: 8, fontWeight: FontWeight.bold, fontFamily: "LeagueSpartan"))),
              width: sz.width /8.5)
        ],
      ),
    ),
  ));
}

Widget CircleBtnWithBorderColor({@required Widget child, Color bordercolor , double radius, Color fillcolor}){
  return Container(
    padding: EdgeInsets.all(radius != null ? radius : 8),
    decoration: new BoxDecoration(
      color: fillcolor != null ? fillcolor : Colors.white,
      shape: BoxShape.circle,
    ),
    child:  Center(
        child:  child
    ),
  );
}

Widget CalendarWeekDayCell(Size sz, String txt){
  return TableCell(child: Padding(
    padding: EdgeInsets.only(top: sz.height * 0.02, bottom: sz.height * 0.025),
    child: Center(child: WhiteTextMD(txt)),
  ));
}
