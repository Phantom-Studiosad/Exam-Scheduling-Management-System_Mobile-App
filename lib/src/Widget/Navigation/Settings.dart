import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'languages.dart';
import 'package:exam_schedule/main.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
@override
_SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool fingerprint = true;
  String email = "lkdharun26@gmail.com";
  String phoneNumber = "+919597342348";
  static String _them;

  getPref() async{
    final prefs = await SharedPreferences.getInstance();
    _them = prefs.getString("_them");
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: Duration(milliseconds: 300),
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Color(0xFF26667d),
        ),
        body: Container(
          child: Container(
            child: SettingsList(
            // backgroundColor: Colors.orange,
            sections: [
              SettingsSection(
                title: 'General',
                // titleTextStyle: TextStyle(fontSize: 30),
                tiles: [
                  SettingsTile(
                    title: 'Dark theme',
                    subtitle:  _them,
                    leading: Icon(Icons.dashboard_customize),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0)),
                              //this right here
                              child: Container(
                                height: 273,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Dark theme", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),),
                                      ListTile(
                                        leading: Icon(Icons.settings_system_daydream_sharp,color: Colors.black,),
                                        title: Text('System Default'),
                                        onTap: () {
                                          AdaptiveTheme.of(context).setSystem();
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _them =  "System Default";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.nightlight_round,color: Colors.black,),
                                        title: Text('Always'),
                                        onTap: () {
                                          AdaptiveTheme.of(context).setDark();
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _them =  "Always";
                                          });
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.lightbulb_outline_sharp,color: Colors.black,),
                                        title: Text('Never'),
                                        onTap: () {
                                          AdaptiveTheme.of(context).setLight();
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _them =  "Never";
                                          });
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: FlatButton(
                                          color: Colors.white,
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.blue),
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
                  SettingsTile(
                    title: 'Language',
                    subtitle: 'English',
                    leading: Icon(Icons.language),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LanguagesScreen()));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Security',
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Lock app in background',
                    leading: Icon(Icons.phonelink_lock),
                    switchValue: lockInBackground,
                    onToggle: (bool value) {
                      setState(() {
                        lockInBackground = value;
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                      title: 'Use fingerprint',
                      leading: Icon(Icons.fingerprint),
                      switchValue: fingerprint,
                      onToggle: (bool value) {
                        setState(() {
                          fingerprint = value;
                        });
                      },
                      ),
                  SettingsTile.switchTile(
                    title: 'Enable Notifications',
                    leading: Icon(Icons.notifications_active),
                    switchValue: notificationsEnabled,
                    onToggle: (bool value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Contact',
                tiles: [
                  SettingsTile(
                    title: 'Phone number',
                    leading: Icon(Icons.phone),
                    onTap: () {
                      launch('tel:' + phoneNumber);
                    },
                  ),
                  SettingsTile(
                    title: 'Email',
                    leading: Icon(Icons.email),
                    onTap: () {
                      launch('mailto:' + email);
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Misc',
                tiles: [
                  SettingsTile(
                      title: 'Terms of Service', leading: Icon(Icons.description)),
                  SettingsTile(
                      title: 'Open source licenses',
                      leading: Icon(Icons.collections_bookmark)),
                ],
              ),
              CustomSection(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 8),
                      child: Image.asset(
                        'assets/settings.png',
                        height: 50,
                        width: 50,
                        color: Color(0xFF777777),
                      ),
                    ),
                    Text(
                      'Version: '+version,
                      style: TextStyle(color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

