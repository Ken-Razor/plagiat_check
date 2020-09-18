import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:plagiatcheck/constant.dart';
import 'package:plagiatcheck/fadeAnimation.dart';
import 'package:plagiatcheck/login/loginPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String warning;

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(
                1.3,
                Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FadeAnimation(
                1.5,
                Text(
                  'Reset Password Here',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                      color: Colors.teal.shade100,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 300.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              FadeAnimation(
                1.7,
                Card(
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      title: TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          email = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Email',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )),
                      ),
                    )),
              ),
              FadeAnimation(
                2.3,
                Card(
                    color: Colors.lightGreen[600],
                    margin:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                    child: new InkWell(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try{
                          final user = await _auth.sendPasswordResetEmail(email: email);
                          if (_auth != null){
                            print("Password reset link has been save to $email");
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Notification",
                              desc: "Password reset link has been save to $email",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Got It",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pushNamed(context, LoginPage.id),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }
                        on PlatformException catch (e) {
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Error",
                            desc: "Please Try Again",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Got It",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pushNamed(context, LoginPage.id),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                      },
                      child: Container(
                        width: 400.0,
                        height: 55.0,
                        child: ListTile(
                            title: Text(
                              "Reset Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor,
                              ),
                            )),
                      ),
                    )),
              ),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
