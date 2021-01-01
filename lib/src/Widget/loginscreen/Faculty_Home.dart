import 'package:exam_schedule/src/Admin.dart';
import 'package:exam_schedule/src/Widget/Navigation/Settings.dart';
import 'package:exam_schedule/src/Widget/Navigation/Support.dart';
import 'package:exam_schedule/src/Widget/loginscreen/Func/FMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exam_schedule/src/Widget/Navigation/About.dart';
import 'package:exam_schedule/src/Widget/Navigation/Downloads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Faculty.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

String eid,date,cid,duration,room,time;
LatLng latLng;
final Set<Marker> _markers = {};

class FHomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  FHomeScreen(this.signOut);
  @override
  _FHomeScreenState createState() => _FHomeScreenState();
}

class _FHomeScreenState extends State<FHomeScreen> {
  String email="lkdharun26@gmail.com";
  final databaseReference = FirebaseFirestore.instance;
  final TextEditingController sid = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  static String choice;
  String finalDate = '';

  getCurrentDate() async{

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }

  getLocation() async {
    var location = new Location();
    location.onLocationChanged.listen((  currentLocation)
    {
      setState(() {
        latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
        _markers.add(Marker(
          markerId: MarkerId("111"),
          position: latLng,
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    });
  }

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
    firestoreInstance.collection("Student").doc(firebaseUser.email.substring(0,16)).get().then((value){
      fname=value.data()["Fname"];
      lname=value.data()["Lname"];
      dept=value.data()["Dept"];
    });
    firestoreInstance.collection("Exam").where("Date",isEqualTo: "$finalDate").get().then((result) {result.docs.forEach((value){
      eid = value.data()["Exam_id"];
      cid = value.data()["Course_id"];
      room = value.data()["Room_no"];
      date = value.data()["Date"];
      duration = value.data()["duration"];
      time = value.data()["time"];
    });
    });
    getLocation();
    getPref();
  }

  Widget _faculty() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Hello',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.greenAccent,
          ),
          children: [
            TextSpan(
              text: '  ',
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: fname,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: ' ',
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: lname,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
          ]),
    );
  }

  Widget _detail() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'F_ID : ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.orangeAccent,
          ),
          children: [
            TextSpan(
              text: firebaseUser.email.substring(0,16),
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "                  ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "Dept : ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.orangeAccent,

              ),
            ),
            TextSpan(
              text: dept,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
          ]),
    );
  }

  Widget _navigate() {
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
                      leading: Icon(Icons.navigation_sharp, size: 60,color: Colors.blueAccent,),
                      title: Text("Exam Details", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'If you are Available for Invigilation you can navigate about to your exam duty',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Navigate'),
                          color: Colors.red,
                          splashColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: (){
                            if(choice.contains("Yes")){
                              setState(() {
                                firestoreInstance.collection("Exam").where("Date",isEqualTo: "$finalDate").get().then((result) {result.docs.forEach((value){
                                  eid = value.data()["Exam_id"];
                                  cid = value.data()["Course_id"];
                                  room = value.data()["Room_no"];
                                  date = value.data()["Date"];
                                  duration = value.data()["duration"];
                                  time = value.data()["time"];
                                });
                                });
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FSchedule()),
                              );
                            }
                            else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Report"),
                                      content: Text("You have no invigilation duties assigned, please click yes in invigilation duties card to assign invigilation duty!!"),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
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

  Widget _schedule() {
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
                      title: Text("Invigilation Duties", style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                      subtitle: Text(
                          'Are you available for invigilation duty?',
                          style: TextStyle(fontSize: 16.0,color: Colors.teal)
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          child: const Text('Yes'),
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
                                  return AlertDialog(
                                    title: Text("Invigilation Report"),
                                    content: Text("Invigilation Duty Assigned"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            choice='Yes';
                                          });
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                        RaisedButton(
                          child: const Text('No'),
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
                                  return AlertDialog(
                                    title: Text("Invigilation Report"),
                                    content: Text("You have no invigilation duties assigned. Carry On With Your Work!!!"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            choice='No';
                                          });
                                        },
                                      )
                                    ],
                                  );
                                });
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
                    MaterialPageRoute(builder: (context) => Admin()),
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
                accountName: Text("FACULTY",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
                accountEmail: Text('faculty@cb.faculties.amrita.edu',style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    "FACULTY",
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
                        _faculty(),
                        SizedBox(height: 10,),
                        _detail(),
                        SizedBox(height: 100,),
                        _schedule(),
                        SizedBox(height: 10,),
                        _navigate()
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
