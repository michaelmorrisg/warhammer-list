import 'package:flutter/material.dart';
import 'army.dart';

class ArmyList {
  List<Army> armyList = [
    Army(title: 'Tzeentch Demons'),
    Army(title: 'Iron Warriors'),
    Army(title: 'Chaos Killteam'),
    Army(title: 'Demons w/ Knight'),
  ];

  getArmy(index, context) {
    return Card(
      child: ListTile(
          title: Text(armyList[index].title,
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
            Navigator.pushNamed(context, '/add-army', arguments: 1);
          }),
    );
  }
}
