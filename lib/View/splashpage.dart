import 'package:zulassung123/View/authpage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zulassung123/globalinfo.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double imgSize = MediaQuery.of(context).size.width / 3;
    return SplashScreen(
      seconds: 3,
      image: Image.asset("assets/logo.png", width: imgSize, height: imgSize * 2),
      photoSize: 100,
      loaderColor: Colors.blue,
      backgroundColor: Colors.lightBlue,
      gradientBackground: LinearGradient(colors: [Colors.cyan, Colors.blue]),
      navigateAfterSeconds: AuthPage(), // MainPage(),
    );
  }
}

//class MainPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<FirebaseUser>(
//      stream: FirebaseAuth.instance.onAuthStateChanged,
//      builder: (context, snapshot){
//        return AuthManagePage(snapshot);
//      }
//    );
//  }
//}

//class SplashPage extends StatefulWidget {
//  @override
//  _SplashPageState createState() => _SplashPageState();
//}
//
//class _SplashPageState extends State<SplashPage> {
//  List<PostModel> posts = List<PostModel>();
//  List<SubscribeModel> subscribes = List<SubscribeModel>();
//
////  GetAllDatas() async{
////    await postController.GetAllPosts();
//////    postController.GetAllPosts().then((value){
//////      setState(() {
//////        posts = value;
//////      });
//////    });
////  }
//
//  @override
//  void initState() {
//    super.initState();
//    //GetAllDatas();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size sz = MediaQuery.of(context).size;
//
//    return Scaffold(
//      body: Container(
//        color: Colors.lightBlue,
//        child: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Image.asset("assets/logo.png", width: sz.width * 0.4, fit: BoxFit.fitWidth),
//              SizedBox(height: sz.height * 0.1),
//              CircularProgressIndicator()
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
