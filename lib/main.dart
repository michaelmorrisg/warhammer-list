import 'package:flutter/material.dart';
import 'routes/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
          child: MaterialApp(
        title: 'Testing Things',
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}

