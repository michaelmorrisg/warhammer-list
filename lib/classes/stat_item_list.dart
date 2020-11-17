import 'stat_item.dart';
import 'package:flutter/material.dart';

class StatItemList {
  List<StatItem> statItemList = [];

  StatItemList(statItems) {
    for (var i = 0; i < statItems.length; i++) {
      this.statItemList.add(StatItem(
        id: statItems[i]['id'],
        color: statItems[i]['color'],
        name: statItems[i]['name'],
        movement: statItems[i]['movement'],
        ballisticSkill: statItems[i]['ballisticSkill'],
        weaponSkill: statItems[i]['weaponSkill'],
        strength: statItems[i]['strength'],
        toughness: statItems[i]['toughness'],
        save: statItems[i]['save'],
        leadership: statItems[i]['leadership'],
        attacks: statItems[i]['attacks'],
        wounds: statItems[i]['wounds'],
      ));
    }
  }
  // List<StatItem> 
  // List<StatItem> statItemList = [
    // StatItem(id: 1, color: Colors.pink, name: 'Pink Horror', movement: '6"', ballisticSkill: '3+', weaponSkill: '4+', strength: '3', toughness: '3', save: '5+', leadership: '7', attacks: '1', wounds: '1'),
    // StatItem(id: 2, color: Colors.blue, name: 'Blue Horror'),
    // StatItem(id: 3, color: Colors.orange, name: 'Flamer'),
    // StatItem(id: 4, color: Colors.red, name: 'Lord of Change'),
    // StatItem(id: 5, color: Colors.purple, name: 'Demon Prince'),
  // ];

  filterList(List<StatItem> selectedStatItems) {
    var list = this.statItemList;
    for (var i = 0; i < selectedStatItems.length; i ++) {
      list.removeWhere((statItem) => statItem.id == selectedStatItems[i].id);
    }
    var filteredList = list.toList();
    filteredList.insert(0, StatItem(id: 0, color: 0xFFFFAB00, name:'Add New'));
    return filteredList;
  }
}
