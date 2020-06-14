import 'stat_item.dart';
import 'package:flutter/material.dart';

class StatItemList {
  List<StatItem> statItemList = [
    StatItem(id: 1, color: Colors.pink, imageText: 'PH', name: 'Pink Horror', movement: '6"', ballisticSkill: '3+', weaponSkill: '4+', strength: '3', toughness: '3', save: '5+', leadership: '7', attacks: '1', wounds: '1'),
    StatItem(id: 2, color: Colors.blue, imageText: 'BH', name: 'Blue Horror'),
    StatItem(id: 3, color: Colors.orange, imageText: 'F', name: 'Flamer'),
    StatItem(id: 4, color: Colors.red, imageText: 'LOC', name: 'Lord of Change'),
    StatItem(id: 5, color: Colors.purple, imageText: 'DP', name: 'Demon Prince'),
  ];

  filterList(List selectedStatItems) {
    var list = this.statItemList;
    for (var i = 0; i < selectedStatItems.length; i ++) {
      list.removeWhere((statItem) => statItem.id == selectedStatItems[i].id);
    }
    return list.toList();
  }

  // StatItem getStatItems(index, context) {
  //   return statItemList[index];
  // }
}
