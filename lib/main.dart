import 'package:zulassung123/Provider/appointprovider.dart';
import 'package:zulassung123/Provider/clientprovider.dart';
import 'package:zulassung123/View/authpage.dart';
import 'package:zulassung123/View/Admin/adminbookpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/authprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        ChangeNotifierProvider<ClientProvider>(create: (context) => ClientProvider()),
        ChangeNotifierProvider<AppointProvider>(create: (context) => AppointProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage()
      ),
    );
  }
}
