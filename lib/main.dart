import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'add_army.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Things',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        accentColor: Colors.amberAccent,
        fontFamily: 'RobotoCondensed',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/add-army': (context) => AddArmy(),
      }
    );
  }
}

