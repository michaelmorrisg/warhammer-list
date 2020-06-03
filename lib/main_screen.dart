import 'package:flutter/material.dart';
import 'army_list.dart';
import 'army.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ArmyList armyList = ArmyList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-army');
              // setState(() {
              //   armyList.armyList.add(Army(title: 'Testing'));
              // });
            }),
        body: ListView.builder(
          itemCount: armyList.armyList.length,
          itemBuilder: (BuildContext context, index) {
            return armyList.getArmy(index, context);
          }
        )
        );
  }
}
