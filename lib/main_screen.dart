import 'package:flutter/material.dart';
import 'army_list.dart';
import 'add_army.dart';
import 'army.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ArmyList armyList = ArmyList();
  dynamic title = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('What do you want to name your new list?'),
                    content: TextField(
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (input) {
                        title = input;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Create'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddArmy(
                                      army: Army(
                                          title: title, statItems: []))));
                        },
                      ),
                    ],
                  );
                });
          }),
      body: ListView.builder(
          itemCount: armyList.armyList.length,
          itemBuilder: (BuildContext context, index) {
            return armyList.armyListItem(index, context);
          }),
    );
  }
}
