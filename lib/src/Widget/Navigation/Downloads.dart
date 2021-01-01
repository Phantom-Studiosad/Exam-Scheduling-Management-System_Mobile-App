import 'package:flutter/material.dart';

class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Downloads"),
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
                 'assets/images/download.png',
                 height: 200,
                 width: 300,
               ),
               Center(
                 child: Align(
                   child: new Text("No Downloads Yet!!",style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold,fontSize: 20)),
                 ),
               ),
             ]
           ),
       ),
    ),
    );
  }
}