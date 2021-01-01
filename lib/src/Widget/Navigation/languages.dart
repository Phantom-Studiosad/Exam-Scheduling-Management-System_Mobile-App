import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';


class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Languages'),
        backgroundColor: Color(0xFF26667d),),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "English",
              trailing: trailingWidget(0),
              onTap: () {
                changeLanguage(0);
              },
            ),
            SettingsTile(
              title: "Hindi",
              trailing: trailingWidget(1),
              onTap: () {
                changeLanguage(1);
              },
            ),
            SettingsTile(
              title: "Malayalam",
              trailing: trailingWidget(2),
              onTap: () {
                changeLanguage(2);
              },
            ),
            SettingsTile(
              title: "Tamil",
              trailing: trailingWidget(3),
              onTap: () {
                changeLanguage(3);
              },
            ),
            SettingsTile(
              title: "Telugu",
              trailing: trailingWidget(4),
              onTap: () {
                changeLanguage(4);
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }

  void changeLanguage(int index) {
    setState(() {
      languageIndex = index;
    });
  }
}