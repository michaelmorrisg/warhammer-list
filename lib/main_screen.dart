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
                          Army newArmy = Army(title: title, statItems: []);
                          setState(() {
                            armyList.armyList.add(newArmy);
                          });
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddArmy(
                                army: newArmy,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                });
          }),
      body: ListView.builder(
          itemCount: armyList.armyList.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              child: ListTile(
                  title: Text(armyList.armyList[index].title,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddArmy(
                                        army: armyList.armyList[index])));
                          }),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              armyList.armyList.removeAt(index);
                            });
                          }),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddArmy(army: armyList[armyListIndex])));
                  }),
            );
          }),
    );
  }
}
