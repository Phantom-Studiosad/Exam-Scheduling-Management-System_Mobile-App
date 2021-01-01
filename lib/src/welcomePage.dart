import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:exam_schedule/src/Admin.dart';
import 'package:exam_schedule/src/Faculty.dart';
import 'package:exam_schedule/src/Student.dart';
import 'package:exam_schedule/src/Widget/Navigation/Settings.dart';
import 'package:exam_schedule/src/Widget/Navigation/Support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'Widget/Navigation/About.dart';
import 'Widget/Navigation/Downloads.dart';
import 'Widget/Navigation/Notification.dart';



class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String email="lkdharun26@gmail.com";

  Widget _faculty() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Faculty()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF26667d).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
            color: Colors.deepOrangeAccent),
        child: Text(
          'Faculty',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'LOGIN AS:',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }


  Widget _student() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Student()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF26667d).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
            color: Colors.deepOrangeAccent),
        child: Text(
          'Student',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }


  Widget _admin() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Admin()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF26667d).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Admin',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ),
    );
  }


  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'EXAM ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 60,
            fontWeight: FontWeight.w900,
            color: Colors.greenAccent,
          ),
          children: [
            TextSpan(
              text: 'SCHEDULING ',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            TextSpan(
              text: 'MANAGEMENT SYSTEM',
              style: TextStyle(color: Colors.greenAccent, fontSize: 30),
            ),
          ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Exam Schedule'),

        actions: [
          IconButton(
              icon: const Icon(Icons.cloud_download,color: Colors.red,),
              tooltip: 'Downloads',
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Download()),
                );
              },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                icon: const Icon(Icons.add_alert,color: Colors.yellowAccent),
                tooltip: 'Notifications',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notificationn()),
                  );
                },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline_rounded,color: Colors.deepOrangeAccent,),
            tooltip: 'About',
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
            },
          ),
        ],
        backgroundColor: Color(0xFF26667d),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Exam Schedule Management System",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
              accountEmail: Text('Version ' + version,style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                backgroundImage: AssetImage('assets/images/splash1.png'),
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
                Share.share('Find all the details related to the exams under one roof. \n Download Exam Schedule,the must-have app! \n https://drive.google.com/file/d/1Cl6WhPjaYJS1pPvxyj39MD06T3H20Ty2/view?usp=sharing',
                    subject: 'Exam Scheduling Management System'),
              },
            ),
          ],
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Please tap Back again to exit'),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: height,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xFF003142),)
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF143642), Color(0xFF26667d)],
              )),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 60.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _label(),
                      _faculty(),
                      SizedBox(
                        height: 20,
                      ),
                      _student(),
                      SizedBox(
                        height: 100,
                      ),
                      _admin(),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: SupportUsBottomAppBar(
      ),
    );
  }

}

class SupportUsBottomAppBar extends StatelessWidget {

  final double fontSize;

  SupportUsBottomAppBar(
      {
        this.fontSize = 15.0});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        'If you 💙 the app, consider donating here >',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize),
      ),
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Support()),
        ),
      },
    );
  }
}

