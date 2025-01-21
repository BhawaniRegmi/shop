import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logistics/NewReUseableWidgets/dispatch.dart';
import 'package:logistics/main_presenter.dart';

import 'package:logistics/newChange/scrollabletest.dart';

import 'package:logistics/scan.dart';

import 'login/login_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashPage createState() => _SplashPage();
}



class _SplashPage  extends State<SplashPage> implements SplashContract{


  BuildContext _ctx;
  SplashPresenter _presenter;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _SplashPage() {

    _presenter = new SplashPresenter(this);

  }

  @override
  void initState() {
    super.initState();


    _checkUserStatus();
  }

  void _checkUserStatus() {
    _presenter.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
        body:  Center(
      child: Container(
        margin: EdgeInsets.all(40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_logo.png"),
          ),
        ),
      ),
    ));
  }

  @override
  void isLogin(bool status) {

    Future.delayed(const Duration(milliseconds: 1000), () {
      if(status == true){
        Navigator.pushAndRemoveUntil(
          context,
          // MaterialPageRoute(builder: (context) => QRViewExample()),
           MaterialPageRoute(builder: (context) => UserMain()),
          // MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
      else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    });

  }
}





