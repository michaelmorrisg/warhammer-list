import 'package:flutter/material.dart';
import 'add_army.dart';
import 'army.dart';

class ArmyList {
  List<Army> armyList = [
    Army(title: 'Tzeentch Demons', avatars: [1,3]),
    Army(title: 'Iron Warriors', avatars: []),
    Army(title: 'Chaos Killteam', avatars: []),
    Army(title: 'Demons w/ Knight', avatars: []),
  ];

  Card armyListItem(armyListIndex, context) {
    return Card(
      child: ListTile(
          title: Text(armyList[armyListIndex].title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print('edit!');
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('delete!');
                  }),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddArmy(army: armyList[armyListIndex])));
          }),
    );
  }
}
