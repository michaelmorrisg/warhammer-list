import 'package:flutter/material.dart';
import 'routes/main_screen.dart';

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
        accentColor: Color(0xFFFFAB00),
        fontFamily: 'RobotoCondensed',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
      }
    );
  }
}

