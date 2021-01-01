import 'package:flutter/material.dart';

class Notificationn extends StatefulWidget {
  @override
  _NotificationnState createState() => _NotificationnState();
}

class _NotificationnState extends State<Notificationn> {

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notifications"),
        actions: <Widget>[
          IconButton(
            onPressed: (null),
            icon: Icon(Icons.delete_sweep_sharp,color: Colors.red,),
          )
        ],
        backgroundColor: Color(0xFF26667d),
      ),
      body: new Container(
        child: Container(
          height: height,
          
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/notify.png',
                  height: 250,
                  width: 300,
                ),
                Center(
                  child: Align(
                    child: new Text("You Have No Notification!!",style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}