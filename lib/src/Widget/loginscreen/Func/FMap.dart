import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:exam_schedule/src/Widget/loginscreen/Faculty_Home.dart';
import '../../../Faculty.dart';

class FSchedule extends StatefulWidget {
  @override
  _FScheduleState createState() => _FScheduleState();
}

class _FScheduleState extends State<FSchedule> {

  GoogleMapController mapController;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  LocationData currentLocation;
  final Set<Marker> _markers = {};




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



  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    firestoreInstance.collection("Student").doc(firebaseUser.email.substring(0,16)).get().then((value){
      fname=value.data()["Fname"];
      lname=value.data()["Lname"];
    });
    getLocation();
  }

  Widget _map(){
    return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 500,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 18.0,
                ),
              ),
            )
          ],
        )
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

  Widget _edetail() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Course_ID : ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.orangeAccent,
          ),
          children: [
            TextSpan(
              text: cid,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "                         ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "Room No : ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.orangeAccent,

              ),
            ),
            TextSpan(
              text: room,
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
  Widget _edetail1() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Date : ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.orangeAccent,
          ),
          children: [
            TextSpan(
              text: date,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "                                 ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
            TextSpan(
              text: "Time : ",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.orangeAccent,

              ),
            ),
            TextSpan(
              text: time,
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


  Widget _student() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Welcome',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: Colors.greenAccent,
          ),
          children: [
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
              text: fname,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
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
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,

              ),
            ),
          ]),
    );
  }


  void _onPressed() {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("Student").doc('cb.en.u4cse19318').get().then((value){

      fname=value.data()["Fname"];
      lname=value.data()["Lname"];
    });
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Schedule"),
        actions: <Widget>[
        ],
        backgroundColor: Color(0xFF26667d),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _student(),
                      SizedBox(height: 10,),
                      _detail(),
                      SizedBox(height: 35,),
                      Text("                   INVIGILATION DUTY", style: TextStyle(fontSize: 20,color: Colors.deepOrange,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      SizedBox(height: 25,),
                      _edetail(),
                      SizedBox(height: 10,),
                      _edetail1(),
                      SizedBox(height: 20,),
                      Text('Venue:',style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepOrangeAccent,
                      ),textAlign: TextAlign.center,),
                      _map(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Record {
  final String Fname;
  final int semester;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Fname'] != null),
        assert(map['semester'] != null),
        Fname = map['Fname'],
        semester = map['semester'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$Fname:$semester>";
}
