import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/authinfo.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Provider/clientprovider.dart';
import 'package:zulassung123/View/Business/businessbookingview.dart';
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/View/Components/common/custominput.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';
import 'package:zulassung123/View/authpage.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:provider/provider.dart';

class BusinessBookPage extends StatefulWidget {
  UserModel user;
  BusinessBookPage(this.user);
  @override
  _BusinessBookPageState createState() => _BusinessBookPageState();
}

class _BusinessBookPageState extends State<BusinessBookPage> {
  static List<String> months = ['Januar','Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'];
  List<int> days = [];
  List<String> years=[];
  var dateUtility = new DateUtil();
  bool monthChange = false;
  bool yearChange = false;
  String email;
  int month;
  int year;

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
    for(int i = 1990; i <2050; i ++){
      years.add(i.toString());
    }
    setState(() {
      month = DateTime.now().month;
      year = DateTime.now().year;
    });

    SetCalendar();


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
          appBar: CustomAppBar1(context,
            leftW: LogoutButton(context),
            centerW: Container(
                padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
                child: Image.asset("assets/Logo.png")),
            rightW: ProfileImage(context, 0.045,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessBookingView(widget.user.email)));
              }
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: sz.width * 0.05, top: sz.height * 0.005, bottom: sz.height * 0.01),
                  color: ColorTheme.Blue,
                  child: WhiteTextSM("TERMINBUCHUNG"),
                ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          StreamBuilder<Object>(
                            stream: firebaseController.GetMonthAppointsWithEmail(month < 10 ? "0" + month.toString() : month.toString(), year.toString(), widget.user.email),
                            builder: (context, snapshot) {
                              List<bool> booked = [];
                              for(int i = 0; i < 35; i ++) booked.add(false);
                              if(snapshot.hasData){
                                List<AppointModel> datas = snapshot.data;
                                for(int i = 0; i < datas.length; i ++){
                                  if(datas[i].name == null || datas[i].name == '') continue;
                                  List<String> split = datas[i].date.split('.');
                                  booked[int.parse(split[1])] = true;
                                }
                              }
                              return Container(
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
                                          return CalendarDayCell(context, days[index].toString(), (days[index] != -1 && booked[days[index]]), makedatestring(year, month, days[index]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){

                                          return CalendarDayCell(context, days[index + 7].toString(), (days[index + 7] != -1 && booked[days[index + 7]]), makedatestring(year, month, days[index + 7]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 14].toString(), (days[index + 14] != -1 && booked[days[index + 14]]), makedatestring(year, month, days[index + 14]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 21].toString(), (days[index + 21] != -1 && booked[days[index + 21]]), makedatestring(year, month, days[index + 21]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 28].toString(), (days[index + 28] != -1 && booked[days[index + 28]]), makedatestring(year, month, days[index + 28]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 35].toString(), (days[index + 35] != -1 && booked[days[index + 35]]), makedatestring(year, month, days[index + 35]));
                                        })
                                    )
                                  ],
                                )
                              );
                            }
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
                                    onTap: (){
                                      setState(() {
                                        month = idx + 1;
                                      });
                                      SetCalendar();
                                      monthChange = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                      onTap: (){
                                        year = int.parse(years[idx]);
                                        SetCalendar();
                                        yearChange = false;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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

  Widget CalendarDayCell(BuildContext context, String txt, bool booked, String date){
    Size sz = MediaQuery.of(context).size;
    return TableCell(child: Padding(
      padding: EdgeInsets.only(top: sz.height * 0.01, bottom: sz.height * 0.01),
      child: GestureDetector(
        onTap: () async{
          print(date.toString());
          if(booked) return;
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

  void openMessageDialog(BuildContext context, String date) {
    Size sz = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _annotationController = TextEditingController();
    showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.05),
                height: sz.height * 0.6,
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
                        CustomTitleTextArea(_annotationController, inputLabelText: "Ammerkungen"),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.04),
                          child: CustomJoinButton(c, title: "Termin einbuchen", onTap: () async{
                            if(_formKey.currentState.validate() != true) {
                              return;
                            }
                            try{
                              AppointModel appoint = new AppointModel(
                                  id: null,
                                  date: date,
                                  name: widget.user.companyname,
                                  telephone: widget.user.telephone,
                                  annotation: _annotationController.text,
                                  email: widget.user.email
                              );
                              print(appoint.toString());
                              await firebaseController.insertAppoint(appoint);
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
