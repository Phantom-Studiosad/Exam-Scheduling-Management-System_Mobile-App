import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_schedule/src/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'Animation/signin_button.dart';
import 'Animation/teddy_controller.dart';
import 'Animation/tracking_input.dart';
import 'Widget/bezierContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widget/loginscreen/Student_Home.dart';

String _emailController;
String _passwordController;
String fname,lname,dept;


class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

enum LoginStatus { notSignIn, signIn }

class _StudentState extends State<Student> {

  final LocalAuthentication localAuth = LocalAuthentication();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  static int res = 1;

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser =  FirebaseAuth.instance.currentUser;

  void forgot(){
    if (_email.text != null) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text).then((result) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Report"),
                content: Text("We have sent you the password reset mail. Please check your email inbox in a few seconds. If you didn't receive your email in a couple of hours, please check your spam or trash bin."),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        res = 1;
                        _teddyController.setres(res);
                        _teddyController.submitPassword();
                      });
                    },
                  )
                ],
              );
            }
        );
      })
          .catchError((err) {
        print(err.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        res = 0;
                        _teddyController.setres(res);
                        _teddyController.submitPassword();
                      });
                    },
                  )
                ],
              );
            });
      });
    }
  }

  void logIn() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController, password: _passwordController)
        .then((result) {
      setState(() {
        res = 1;
        _teddyController.setres(res);
        _teddyController.submitPassword();
        firestoreInstance.collection("Student").doc(_emailController.substring(0,16)).get().then((value){
          fname=value.data()["Fname"];
          lname=value.data()["Lname"];
          dept=value.data()["Dept"];
        });
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SHomeScreen(signOut),),

      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      res = 0;
                      _teddyController.setres(res);
                      _teddyController.submitPassword();
                    });

                  },
                )
              ],
            );
          });
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  TeddyController _teddyController;

  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Back',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white))
          ],
        ),
      ),
    );
  }
  Widget _emailbutton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if(_email.text.contains("@cb.students.amrita.edu")){
          forgot();
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("NOT AUTHORISED"),
                  content: Text("You are not authorised to change password in student page!!!"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          res = 0;
                          _teddyController.setres(res);
                          _teddyController.submitPassword();
                        });
                      },
                    )
                  ],
                );
              });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: <BoxShadow>[
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.greenAccent, Colors.green])),
        child: Text(
          'Send Email',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),),

    );
  }

  Widget _Fpass(){
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                //this right here
                child: Container(
                  height: 228,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Email Address", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _email,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              hintText: 'Enter your email address',
                              hintStyle: TextStyle(color: Colors.black38),
                              filled: true),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              _emailbutton(),
                            ],

                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blue,fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text('Forgot Password ?',
          style: TextStyle(
              color: Colors.black,fontSize: 14, fontWeight: FontWeight.w500),),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Widget _title() {
    return RichText(
      text: TextSpan(
          text: 'EXAM ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.green,
          ),
          children: [
            TextSpan(
              text: 'SCHEDULING ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'MANAGEMENT SYSTEM',
              style: TextStyle(color: Colors.green, fontSize: 15,),
            ),
          ]),
    );
  }


  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(

      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.0, 1.0],
                        colors: [Color(0xFF143642), Color(0xFF26667d)],
                      ),
                    ),
                  )),
              Stack(
                children: <Widget>[
                  Positioned(
                      top: -height * .15,
                      right: -MediaQuery
                          .of(context)
                          .size
                          .width * .4,
                      child: BezierContainer()),
                  Container(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                                child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _title(),
                                    ]
                                ),
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                                height: 200,
                                padding: const EdgeInsets.only(left: 30.0, right:30.0),
                                child: FlareActor(
                                  "assets/Teddy.flr",
                                  shouldClip: false,
                                  alignment: Alignment.bottomCenter,
                                  fit: BoxFit.contain,
                                  controller: _teddyController,
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Username",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueAccent),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TrackingTextInput(
                                            onCaretMoved: (Offset caret) {
                                              _teddyController.lookAt(caret);
                                            },
                                            onTextChanged: (String val) {
                                              _teddyController.setUsername(val);
                                              _emailController = val;
                                            },
                                          ),
                                          Text("Password",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueAccent),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TrackingTextInput(
                                            isObscured: true,
                                            onCaretMoved: (Offset caret) {
                                              _teddyController.coverEyes(caret != null);
                                              _teddyController.lookAt(null);
                                            },
                                            onTextChanged: (String val) {
                                              _teddyController.setPassword(val);
                                              _passwordController = val;
                                            },
                                          ),
                                          SigninButton(
                                              child: Text("Login",
                                                  style: TextStyle(
                                                      fontFamily: "RobotoMedium",
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                              onPressed: () {
                                                if (_formKey.currentState.validate()) {
                                                  if(_emailController.contains("@cb.students.amrita.edu")){
                                                    setState(() {
                                                      firestoreInstance.collection("Student").doc(_emailController.substring(0,16)).get().then((value){
                                                        fname=value.data()["Fname"];
                                                        lname=value.data()["Lname"];
                                                        dept=value.data()["Dept"];
                                                      });
                                                    });
                                                    logIn();
                                                  }
                                                  else{
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text("NOT AUTHORISED"),
                                                            content: Text("You are not authorised to login through student page!!!"),
                                                            actions: [
                                                              FlatButton(
                                                                child: Text("Ok"),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    res = 0;
                                                                    _teddyController.setres(res);
                                                                    _teddyController.submitPassword();
                                                                  });
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  }
                                                }
                                              }),
                                          _Fpass()
                                        ],
                                      )),
                                )),
                            SizedBox(height: 20,),
                          ]),
                    ),
                  ),
                ],
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          )),
    );
  }
}