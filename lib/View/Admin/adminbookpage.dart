import 'dart:io';

import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/dates.dart';
import 'package:zulassung123/Model/user.dart';
import 'package:zulassung123/Provider/appointprovider.dart';
import 'package:zulassung123/View/Admin/pdfviewpage.dart';
import 'package:zulassung123/View/Components/CustomerList/customeritem.dart';
import 'package:zulassung123/View/Components/common/customappbar.dart';
import 'package:zulassung123/View/Components/common/custombuttons.dart';
import 'package:zulassung123/View/Components/common/custominput.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';
import 'package:zulassung123/View/Admin/detailinfodart.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import '';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class AdminBookPage extends StatefulWidget {
  @override
  _AdminBookPageState createState() => _AdminBookPageState();
}

class _AdminBookPageState extends State<AdminBookPage> {
  static List<String> months = ['Januar','Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'];
  List<int> days = [];
  List<String> years=[];
  var dateUtility = new DateUtil();
  bool monthChange = false;
  bool yearChange = false;
  int month;
  int year;
  int day;
  bool isPrint;
  List<AppointModel> appoints;
  List<UserModel> users;

  makedatestring(int yy, int mm, int dd){
    if(dd == -1) return "*";
    String m = mm < 10 ? "0" + mm.toString() : mm.toString();
    String d = dd < 10 ? "0" + dd.toString() : dd.toString();
    return d + "." + m + "." + yy.toString();
  }

  SetCalendar(){
    int numberofdays = dateUtility.daysInMonth(month, year);
    int weekdayOfFirstDay = DateTime(year, month, 1).weekday;
    int numberOfDaysPrevMonth = month == 1 ? 31 : dateUtility.daysInMonth(month - 1, year);
    days.clear();
    setState(() {
      for(int i = 0; i < 42; i ++){
        if(i >= weekdayOfFirstDay - 1 && i < weekdayOfFirstDay + numberofdays -1){
          days.add(i - weekdayOfFirstDay + 2);
        }else days.add(-1);
      }
    });

  }

  String ChangeDateFormat(String date){
    List<String> splits = date.split('.');
    return splits[1] + "." + splits[0] + "." + splits[2];
  }


  @override
  void initState() {
    for(int i = 1990; i <2050; i ++){
      years.add(i.toString());
    }
    setState(() {
      isPrint = false;
      users = [];
      month = DateTime.now().month;
      year = DateTime.now().year;
      day = DateTime.now().day;
    });
    appoints = [];
    SetCalendar();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    double calendarHeight = 0.18 * sz.height + 244;
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar1(context,
            leftW: LogoutButton(context),

            centerW: Container(
                padding: EdgeInsets.symmetric(vertical: sz.height * 0.015),
                child: Image.asset("assets/Logo.png")),
            rightW: isPrint? PrintButton(context, 0.055,
                onTap: () async{
                   users = await firebaseController.GetAllUsers();
                   Map<String, UserModel> maps = Map<String, UserModel>();
                   for(int i = 0; i < users.length; i ++){
                     maps[users[i].telephone] = users[i];
                   }
                   List<AppointModel> appoints = await firebaseController.GetFutureAppointsDataFromDate(day<10 ? "0" + day.toString() : day.toString() ,month < 10 ? "0" + month.toString() : month.toString(), year.toString());
                   List<UserModel> temp = [];
                   for(int i = 0; i < appoints.length; i ++){
                     if(appoints[i].email == null || appoints[i].email == ''){
                        UserModel tp = new UserModel();
                        tp.companyname = appoints[i].name;
                        tp.telephone = appoints[i].telephone;
                        temp.add(tp);
                        continue;
                     }
                     temp.add(maps[appoints[i].telephone]);
                   }
                   print("hereeeeeeeeeeeeee");
                   await _generatePdfAndView(context, temp, appoints);
                }
            ) : Container(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTitleBar(sz, "ADMINISTRATION"),
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
                      height: calendarHeight + 50, //sz.height * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          StreamBuilder<Object>(
                            stream: firebaseController.GetMonthAppointsData(month < 10 ? "0" + month.toString() : month.toString(), year.toString()),
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
                                height: calendarHeight, //sz.height * 0.5,
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
                                          return CalendarDayCell(context, days[index].toString(), (days[index] != -1 && booked[days[index]]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 7].toString(), (days[index + 7] != -1 && booked[days[index + 7]]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 14].toString(), (days[index + 14] != -1 && booked[days[index + 14]]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 21].toString(), (days[index + 21] != -1 && booked[days[index + 21]]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 28].toString(), (days[index + 28] != -1 && booked[days[index + 28]]));
                                        })
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorTheme.Grey,
                                        ),
                                        children: List.generate(7, (index){
                                          return CalendarDayCell(context, days[index + 35].toString(), (days[index + 35] != -1 && booked[days[index + 35]]));
                                        })
                                    ),
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
                            height:sz.height * 0.4,
                            width: sz.width * 0.3,
                            child: ListView.builder(
                                itemCount: months.length,
                                itemBuilder: (context, int idx){
                                  return GestureDetector(
                                    onTap: ()async{
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
                              height:sz.height * 0.4,
                              width: sz.width * 0.3,
                              child: ListView.builder(
                                  itemCount: years.length,
                                  itemBuilder: (context, int idx) {
                                    return GestureDetector(
                                      onTap: ()async{
                                        setState(() {
                                          year = int.parse(years[idx]);
                                        });
                                        SetCalendar();
                                        yearChange = false;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                ),
                Container(
                    height: sz.height * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: sz.width * 0.05, vertical: sz.height * 0.03),
                    child:StreamBuilder<Object>(
                      stream: firebaseController.GetAppointsDataFromDate(day<10 ? "0" + day.toString() : day.toString() ,month < 10 ? "0" + month.toString() : month.toString(), year.toString()),
                      builder: (context, snapshot) {
                        int postcnt = 0;
                        if(snapshot.hasError || !snapshot.hasData || snapshot == null) {
                          print("Error");
                          return Container();
                        }
                        List<AppointModel> datas = snapshot.data;
                        return ListView.builder(
                            itemCount: datas == null ? 0 : datas.length,
                            itemBuilder: (context, int idx) {
                              if(datas[idx].name == null || datas[idx].name == '') return Container();
                              return CustomerItem(
                                context,
                                datas[idx].name,
                                bookdate: ChangeDateFormat(datas[idx].date) ,
                                annotation: datas[idx].annotation,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailInfo(datas[idx].name, datas[idx].email, datas[idx].telephone)));
                                }
                              );
                            }
                        );
                      }
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _generatePdfAndView(BuildContext context, List<UserModel> _users, List<AppointModel> appoints) async {
    if(_users.length == 0) return;
    Size sz = MediaQuery.of(context).size;
    final font = await rootBundle.load("assets/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final fontBold = await rootBundle.load("assets/OpenSans-Bold.ttf");
    final ttfBold = pw.Font.ttf(fontBold);
    final fontItalic = await rootBundle.load("assets/OpenSans-Italic.ttf");
    final ttfItalic = pw.Font.ttf(fontItalic);
    final fontBoldItalic = await rootBundle.load("assets/OpenSans-BoldItalic.ttf");
    final ttfBoldItalic = pw.Font.ttf(fontBoldItalic);
    final pw.ThemeData themeDD = pw.ThemeData.withFont(
      base: ttf,
      bold: ttfBold,
      italic: ttfItalic,
      boldItalic: ttfBoldItalic,
    );
    pw.Document pdf = new pw.Document(theme: themeDD);
    for(int i = 0; i < _users.length; i ++){
      print("+++ " + _users[i].companyname);
    }
  print("uuuuuuuuuuuuuuuuuuuuuuuuu");
    pdf.addPage(

        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
            build: (context) => [
              pw.Container(
                  child: pw.Column(
                      children: [
                        pw.Text(makedatestring(year, month, day), style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: sz.height * 0.01)
                      ]
                  )
              ),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['No','Unternehmen', 'Ansprechpartner', 'Straße', 'Ort',	'PLZ', 'E-Mail', 'Telefonnummer', 'Anmerkung'],
                //...bills.map((item) => [uniqueList.indexOf(item), item.recordDate, item.name, displayNumberFormat(item.cost.toStringAsFixed(2)) , item.currency.substring(3), item.meanOfPayment, item.category, item.location]),
                ..._users.asMap().entries.map((item) => [(item.key + 1).toString(), item.value.email == null ? '' : item.value.companyname, item.value.email == null ? item.value.companyname : item.value.contactpartner, item.value.email == null ? '' : item.value.streetname ,  item.value.email == null ? '' : item.value.place, item.value.email == null ? '' : item.value.postcode, item.value.email == null ? '' : item.value.email, item.value.telephone, appoints[item.key].annotation]),
                // <String>['', '', 'H', 'H', '', 'H']
              ], headerStyle: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold), cellStyle:pw.TextStyle(fontSize: 6)),
            ]
        )
    );

    if(users.length > 0) {
      final directory = await getExternalStorageDirectory();
      final myImagePath = '${directory.path}/MyImages';
      await new Directory(myImagePath).create();
      var dt = DateTime.parse(DateTime.now().toString());
      DateTime now = DateTime.now();
      String pathdate = now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.minute.toString() + now.second.toString();
      final path = '$myImagePath/$pathdate.pdf';
      final File file = File(path);
      file.writeAsBytesSync(pdf.save());
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PdfViewerPage(path: path, name:"zulassung123.pdf"),
          )
      );
    } else {
//      _scaffoldkey.currentState.showSnackBar(SnackBar(
//          content: Text('It doesnot exist BELEGE')
//      ));
    }
  }


  Widget CalendarDayCell(BuildContext context, String txt,bool booked){
    Size sz = MediaQuery.of(context).size;
    return TableCell(child: Padding(
      padding: EdgeInsets.only(top: sz.height * 0.01, bottom: sz.height * 0.01),
      child: GestureDetector(
        onTap: (){
          if(txt == "-1") return;
          setState(() {
            isPrint = true;
            day = int.parse(txt);
          });
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
