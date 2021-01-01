import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'ESMS',
        email: 'lkdharun26@gmail.com',
      ),
      appBar: new AppBar(
        title: new Text("About"),
        actions: <Widget>[
        ],
        backgroundColor: Color(0xFF26667d),
      ),
      body: new Container(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: height,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xFF003142),
                    )
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF143642), Color(0xFF26667d)],
              )),
          child: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal,
            logo: AssetImage('assets/images/splash1.png'),
            email: 'lkdharun26@gmail.com',
            companyName: 'ESMS',
            companyColor: Colors.teal.shade100,
            phoneNumber: '+919597342348',
            website: 'https://confident-tesla-1cccc2.netlify.app/',
            githubUserName: 'dharun276',
            linkedinURL: 'https://www.linkedin.com/in/dharun-narayanan-l-k-407459197/',
            taglineColor: Colors.teal.shade100,
            twitterHandle: 'dharun_official',
            instagram: '_dharun_26',
          ),
        ),
      ),
    );
  }
}