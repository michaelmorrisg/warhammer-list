import 'stat_item.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

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
        abilities: statItems[i]['abilities'],
        degrades: statItems[i]['degrades'],
        damageTable: statItems[i]['damageTable']
      ));
    }
  }

  filterList(List<StatItem> selectedStatItems) {
    var list = this.statItemList;
    for (var i = 0; i < selectedStatItems.length; i ++) {
      list.removeWhere((statItem) => statItem.id == selectedStatItems[i].id);
    }
    var filteredList = list.toList();
    filteredList.insert(0, StatItem(id: 0, color: getColorNameFromColor(Color(0xFFFFAB00)).getCode, name:'Add New'));
    return filteredList;
  }
}
