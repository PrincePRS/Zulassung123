import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/Model/standarduser.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ClientProvider extends ChangeNotifier{

  List<bool> _appoints;

  ClientProvider(){
    _appoints = [];
    initdatas();
  }

  initdatas(){
    for(int i = 0; i < 35; i ++){
      _appoints.add(false);
    }
  }

  List<bool> get appoints => _appoints;

  void  UpdateAppoints(int yy, int mm) async{
    List<StandardUser> books = await sqliteController.getMonthdatas(mm < 10 ? "0" + mm.toString() : mm.toString(), yy.toString());
    //List<StandardUser> books = await sqliteController.getLists();
    print("Count ->" + books.length.toString());
    _appoints.clear();
    initdatas();
    for(int i = 0; i < books.length; i ++){
      List<String> split = books[i].date.split('.');
      int day = int.parse(split[0]);
      print(day.toString());
      _appoints[day] = true;
    }
    print(_appoints.length.toString());
    print("********");
    notifyListeners();
  }
}