import 'package:zulassung123/Model/appoint.dart';
import 'package:zulassung123/globalinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppointProvider extends ChangeNotifier{

  List<AppointModel> _appoints;
  List<bool> _bookStates;

  AppointProvider(){
    _appoints = [];
    _bookStates = [];
  }

  initdatas(){
    for(int i = 0; i < 35; i ++){
      _bookStates.add(false);
    }
  }

  List<AppointModel> get appoints => _appoints;
  List<bool> get bookStates => _bookStates;

  void UpdateAppoints(int yy, int mm) async{
    _appoints = await firebaseController.GetAppointFutureData(mm < 10 ? "0" + mm.toString() : mm.toString(), yy.toString());
    //List<StandardUser> books = await sqliteController.getLists();
    print("Count ->" + _appoints.length.toString());
    _bookStates.clear();
    initdatas();
    for(int i = 0; i < _appoints.length; i ++){
      List<String> split = _appoints[i].date.split('.');
      int day = int.parse(split[1]);
      print(day.toString());
      _bookStates[day] = true;
    }
    print(_appoints.length.toString());
    print("********");
    notifyListeners();
  }

}