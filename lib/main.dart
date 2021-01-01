import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'src/SplashScreen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

final String version= "1.0.7";

void main() async {
  GoogleMap.init('API_KEY');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;

  const MyApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return AdaptiveTheme(
        light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blue,
        ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        accentColor: Colors.blue,
        textTheme: TextTheme(
          subhead: TextStyle(color: Colors.red),
        ),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'ESMS',
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}

