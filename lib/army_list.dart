import 'package:flutter/material.dart';
import 'add_army.dart';
import 'army.dart';
import 'stat_item.dart';

class ArmyList {
  List<Army> armyList = [
    Army(title: 'Tzeentch Demons', statItems: [
      StatItem(id: 1, imageText: 'PH', name: 'Pink Horror'),
      StatItem(id: 2, imageText: 'BH', name: 'Blue Horror'),
      StatItem(id: 3, imageText: 'F', name: 'Flamer'),
    ]
    ),
    Army(title: 'Iron Warriors', statItems: []),
    Army(title: 'Chaos Killteam', statItems: []),
    Army(title: 'Demons w/ Knight', statItems: []),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddArmy(army: armyList[armyListIndex])));
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('delete!');
                  }),
            ],
          ),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AddArmy(army: armyList[armyListIndex])));
          }),
    );
  }
}
