import 'package:zulassung123/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier{
  bool _authPageType;    //
  int _roleId;
  UserModel _user;

  AuthProvider(){
    _user = new UserModel();
    _authPageType = false;
    _imgcapture = '';
    _roleId = -1;
  }
  bool get authPageType => _authPageType;
  int get roleId => _roleId;
  UserModel get user=> _user;



  void UpdateUser(UserModel u){
    _user = u;
    notifyListeners();
  }

  void UpdateRole(int role){
    _roleId = role;
    notifyListeners();
  }

  void toogle(){
    _authPageType = !_authPageType;
    notifyListeners();
  }

  String get imgcapture => _imgcapture;
  String _imgcapture;
  void UpdateCaptureState(String state) {
    _imgcapture = state;
    notifyListeners();
  }
}