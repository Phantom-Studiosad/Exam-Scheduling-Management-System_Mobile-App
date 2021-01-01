import 'package:exam_schedule/src/Faculty.dart';
import 'package:exam_schedule/src/Widget/Navigation/Settings.dart';
import 'package:exam_schedule/src/Widget/Navigation/Support.dart';
import 'package:exam_schedule/src/Widget/loginscreen/Func/add_exam.dart';
import 'package:exam_schedule/src/Widget/loginscreen/func/add_admin.dart';
import 'package:exam_schedule/src/Widget/loginscreen/func/add_student.dart';
import 'package:exam_schedule/src/Widget/loginscreen/func/add_faculty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exam_schedule/src/Widget/Navigation/About.dart';
import 'package:exam_schedule/src/Widget/Navigation/Downloads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AHomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  AHomeScreen(this.signOut);
  @override
  _AHomeScreenState createState() => _AHomeScreenState();
}

class _AHomeScreenState extends State<AHomeScreen> {
  String email="lkdharun26@gmail.com";
  final databaseReference = FirebaseFirestore.instance;
  final TextEditingController sid = TextEditingController();
  final TextEditingController fid = TextEditingController();
  final TextEditingController aid = TextEditingController();
  final TextEditingController eid = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  Widget _admin() {
    return InkWell(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),

                elevation: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.verified_user_rounded, size: 60,color: Colors.cyanAccent,),
                      title: Text("ADMIN", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'The admin is responsible for the upkeep, configuration, and reliable operation of computer systems, managing students , faculties and exam details.',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Add Admin'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterAdmin()),
                            );
                          },
                        ),
                        RaisedButton(
                          child: const Text('Delete Admin'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
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
                                            Text("A_ID", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              controller: aid,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  fillColor: Color(0xfff3f3f4),
                                                  hintText: 'Enter admin aid',
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
                                                  _ADeletebutton(),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _faculty() {
    return InkWell(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),

                elevation: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.supervised_user_circle_sharp, size: 60,color: Colors.pinkAccent,),
                      title: Text("Faculty", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'Faculties are dynamically for examination with invigilation duties. Whenever the faculty marks their presence on their portal, the system allocates the examination hall for invigilation to the faculty.',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Add Faculty'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterFaculty()),
                            );
                          },
                        ),
                        RaisedButton(
                          child: const Text('Delete Faculty'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
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
                                            Text("F_ID", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              controller: fid,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  fillColor: Color(0xfff3f3f4),
                                                  hintText: 'Enter faculty fid',
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
                                                  _FDeletebutton(),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _student() {
    return InkWell(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),

                elevation: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.people_sharp, size: 60,color: Colors.lightGreenAccent,),
                      title: Text("Student", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'A student is primarily a person enrolled in a school or other educational institution and who is under learning with goals of acquiring knowledge, developing professions and achieving easy employment at a particular field.',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Add Student'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterStudent()),
                            );
                          },
                        ),
                        RaisedButton(
                          child: const Text('Delete Student'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
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
                                            Text("S_ID", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              controller: sid,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  fillColor: Color(0xfff3f3f4),
                                                  hintText: 'Enter student sid',
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
                                                  _SDeletebutton(),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _exam() {
    return InkWell(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),

                elevation: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book_rounded, size: 60,color: Colors.purpleAccent,),
                      title: Text("Exam", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'A test or examination is an educational assessment intended to measure a test-takers knowledge, skill, aptitude, physical fitness, or classification in many other topics.',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Add Exam'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterExam()),
                            );
                          },
                        ),
                        RaisedButton(
                          child: const Text('Delete Exam'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
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
                                            Text("E_ID", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            SizedBox(height: 10,),
                                            TextFormField(
                                              controller: eid,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  fillColor: Color(0xfff3f3f4),
                                                  hintText: 'Enter exam eid',
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
                                                  _EDeletebutton(),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }


  Widget _SDeletebutton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (sid.text.contains("cb.en.u4")) {
          firestoreInstance.collection("Student").doc(sid.text).get().then((value){
            if(value.exists != null) {
              deleteStudent();
            }
          });
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("No Student "+ "\""+sid.text+"\""+" available!!!"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        sid.clear();
                        Navigator.of(context).pop();
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
                colors: [Colors.greenAccent, Colors.purple])),
        child: Text(
          'Delete Student',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),),

    );
  }

  Widget _EDeletebutton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (eid.text.contains("10")) {
          firestoreInstance.collection("Exam").doc(eid.text).get().then((value){
            if(value.exists != null) {
              deleteExam();
            }
          });
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("No Student "+ "\""+eid.text+"\""+" available!!!"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        eid.clear();
                        Navigator.of(context).pop();
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
                colors: [Colors.greenAccent, Colors.purple])),
        child: Text(
          'Delete Exam',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),),

    );
  }

  Widget _ADeletebutton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (aid.text.contains("admin")) {
          firestoreInstance.collection("Admin").doc(aid.text).get().then((value){
            if(value.exists != null) {
              deleteAdmin();
            }
          });
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("No Admin "+ "\""+aid.text+"\""+" available!!!"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        aid.clear();
                        Navigator.of(context).pop();
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
                colors: [Colors.deepOrange, Colors.green])),
        child: Text(
          'Delete Admin',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),),

    );
  }

  Widget _FDeletebutton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (fid.text.contains("@cb.faculties.amrita.edu")) {
          firestoreInstance.collection("Faculty").doc(fid.text).get().then((value){
            if(value.exists != null) {
              deleteFaculty();
            }
          });
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("No Found "+ "\""+fid.text+"\""+" available!!!"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        fid.clear();
                        Navigator.of(context).pop();
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
                colors: [Colors.yellowAccent, Colors.red])),
        child: Text(
          'Delete Faculty',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),),

    );
  }


  Future<void> deleteStudent() async {
    if(sid.text != null){
      try {
        databaseReference.collection('Student').doc(sid.text).delete();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("\""+ sid.text+"\"" +" is successfully removed from database."),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      sid.clear();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }catch (e) {
        print(e.toString());
      }
    }
  }
  Future<void> deleteExam() async {
    if(eid.text != null){
      try {
        databaseReference.collection('Exam').doc(eid.text).delete();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("\""+ eid.text+"\"" +" is successfully removed from database."),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      sid.clear();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteFaculty() async {
    if(fid.text != null){
      try {
        databaseReference.collection('Faculty').doc(fid.text).delete();

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("\""+ fid.text+"\"" +" is successfully removed from database."),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      fid.clear();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteAdmin() async {
    if(aid.text != null){
      try {
        databaseReference.collection('Admin').doc(aid.text).delete();

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("\""+ aid.text+"\"" +" is successfully removed from database."),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      aid.clear();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }catch (e) {
        print(e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
          msg: 'Back Button Disabled',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        return false;
      },
      child: Scaffold(appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: 'Logout',
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Faculty()),
                        (Route<dynamic> route) => false);
              });
            },
          )
        ],
        backgroundColor: Color(0xFF26667d),
      ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("ADMIN",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
                accountEmail: Text('admin@cb.admin.amrita.edu',style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    "ADMIN",
                    style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF26667d),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/cover.png'))),
              ),
              ListTile(
                leading: Icon(Icons.home_sharp,),
                title: Text('Home'),
                selected: true,
                selectedTileColor: Colors.grey,
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.download_sharp),
                title: Text('Downloads'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Download()),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.monetization_on_sharp),
                title: Text('Support'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Support()),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback_sharp),
                title: Text('Feedback'),
                onTap: () {
                  launch('mailto:' + email);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_sharp),
                title: Text('Settings'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  ),
                },
              ),
              Divider(thickness: 1,),
              ListTile(
                title: Text('Extras',style: TextStyle(fontWeight: FontWeight.w300),),
              ),
              ListTile(
                leading: Icon(Icons.info_sharp),
                title: Text('About'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.rate_review_sharp),
                title: Text('Leave a review'),
                onTap: () {
                  launch('mailto:' + email);
                },
              ),
              ListTile(
                leading: Icon(Icons.share_sharp),
                title: Text('Tell a friend'),
                onTap: () =>{
                  Share.share('Find all the details related to the exams under one roof. \n Download Exam Schedule,the must-have app! \n https://drive.google.com/file/d/19qJwhG_PSSHkMFHB5Njdvb67Jpc7-Bhg/view?usp=sharing',
                      subject: 'Exam Scheduling Management System'),
                },
              ),
            ],
          ),
        ),
        body: new Container(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xFF003142),
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 20)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF143642), Color(0xFF26667d)],
                )),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _exam(),
                        SizedBox(height: 10,),
                        _student(),
                        SizedBox(height: 10,),
                        _faculty(),
                        SizedBox(height: 10,),
                        _admin(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),),

    );
  }
}
