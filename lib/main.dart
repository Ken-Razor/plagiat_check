import 'package:flutter/material.dart';
import 'package:plagiatcheck/constant.dart';
import 'package:plagiatcheck/landingPage.dart';
import 'package:plagiatcheck/login/loginPage.dart';
import 'package:plagiatcheck/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(bodyText2: TextStyle(color: kBodyTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreenPage.id,
      routes: {
        SplashScreenPage.id: (context) => SplashScreenPage(),
        LoginPage.id: (context) => LoginPage(),
        MyBottomNavigationBar.id: (context) => MyBottomNavigationBar(),
      },
    );
  }
}
