import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plagiatcheck/login/loginPage.dart';

import 'landingPage.dart';


class SplashScreenPage extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  startSplashScreen() async{
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_){
            return LoginPage();
          })
      );
    });
  }
  void initState() {
    startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.lightGreen[600],
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.lightGreen[600]),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      "assets/images/logo.png",
//                  width: 500.0,
//                  height: 500.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "\n #PlagiarismeCheck\n \nCopyright by Kenthea\n \n",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
