import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upi/flutter_upi.dart';
import 'dart:async';



class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {

  String upi;
  Future _initiateTransaction;
  GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
  }

  Future<String> initTransaction(String app) async {
    String response = await FlutterUpi.initiateTransaction(
        app: app,
        pa: upi,
        pn: "Dharun Narayanan",
        tr: "TR1234",
        tn: "Support",
        am: "",
        cu: "INR",
        url: "https://www.google.com");
    print(response);

    return response;
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Support"),
        actions: <Widget>[],
        backgroundColor: Color(0xFF26667d),
      ),
      body: new Container(
        child: Container(
          padding: EdgeInsets.all(10),
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
          child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Text("Make a contribution",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.left,),
                SizedBox(height: 10),
                Text(
                    "This will be a donation for the effort of developing Exam Schedule"
                        " which brings resources from different websites "
                        "under a single roof right at your fingertips. To develop an open-"
                        "source software like this takes technical knowledge, time, and "
                        "effort. I would be very glad if you can appreciate my work with "
                        "your kind donations.",style: TextStyle(color: Colors.white,fontSize: 15)
                ),
                SizedBox(height: 20),
                Text("Thank you in advance,\nDHARUN NARAYANAN L K",style: TextStyle(color: Colors.white,fontSize: 15)),
                SizedBox(height: 20),
                Center(
                    child: new Text("Donate using",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            _initiateTransaction = initTransaction(FlutterUpiApps.GooglePay);
                            setState(() {});
                            upi = "lkdharun@okaxis";
                          },
                          child: Image(
                            image: AssetImage('assets/Payment/Gpay.png'),
                            height: 100,
                          )
                      ),
                      SizedBox(height: 10),
                      Text("(or)",style: TextStyle(color: Colors.yellowAccent,fontSize: 25),),
                      SizedBox(height: 10),
                      FlatButton(
                          onPressed: () {
                            _initiateTransaction = initTransaction(FlutterUpiApps.PhonePe);
                            setState(() {});
                            upi = "9597342348@ybl";
                            },
                          child: Image(
                            image: AssetImage('assets/Payment/phonepe.png'),
                            height: 100,
                          )
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}