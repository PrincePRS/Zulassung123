import 'package:zulassung123/Controller/firebasecontroller.dart';
import 'package:zulassung123/Controller/sqlitecontroller.dart';
import 'package:flutter/material.dart';

class ColorTheme{
  static const Color Black = Color(0xff362425);
  static const Color Red  = Color(0xffc45f6c);
  static const Color Grey = Color(0xffefefef);
  static const Color Blue = Color(0xff014b78);
  static const Color Orange = Color(0xfffba12c);
}

final SqliteController sqliteController = SqliteController();
final FirebaseController firebaseController = FirebaseController();