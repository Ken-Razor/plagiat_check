import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:plagiatcheck/constant.dart';
import 'package:plagiatcheck/fadeAnimation.dart';
import 'package:plagiatcheck/landingPage.dart';
import 'package:plagiatcheck/login/loginPage.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);
  final requiredValidator = RequiredValidator(errorText: 'this field is required');

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String phone;
  String rePassword;



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
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FadeAnimation(
                1.5,
                Text(
                  'Create a New Account',
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
                      title: TextFormField(
                        validator: EmailValidator(errorText: 'enter a valid email address'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          email = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )),
                      ),
                    )),
              ),
              FadeAnimation(
                1.9,
                Card(
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.teal,
                      ),
                      title: TextFormField(
                        obscureText: _obscureText,
                        onChanged: (val) => password = val,
                        // assign the the multi validator to the TextFormField validator
                        validator: passwordValidator,
                        autofocus: false,
                        initialValue: '',
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle();
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _obscureText
                                  ? Colors.grey
                                  : Colors.lightGreen[600],
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
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
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, MyBottomNavigationBar.id);
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        width: 400.0,
                        height: 55.0,
                        child: ListTile(
                            title: Text(
                              "Sign Up",
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
              FadeAnimation(
                2.3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an Account?',
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login Here',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
