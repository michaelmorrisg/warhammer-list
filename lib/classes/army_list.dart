import 'army.dart';
import 'stat_item.dart';

class ArmyList {
  List<Army> armyList = [
    Army(title: 'Tzeentch Demons', statItems: [
      StatItem(id: 1, imageText: 'PH', name: 'Pink Horror', movement: '6"'),
      StatItem(id: 2, imageText: 'BH', name: 'Blue Horror'),
      StatItem(id: 3, imageText: 'F', name: 'Flamer'),
    ]
    ),
    Army(title: 'Iron Warriors', statItems: []),
    Army(title: 'Chaos Killteam', statItems: []),
    Army(title: 'Demons w/ Knight', statItems: []),
  ];
}