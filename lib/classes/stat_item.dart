import 'package:flutter/material.dart';

class StatItem {
  int id;
  Color color;
  String name;
  String imageText;
  String movement;
  String weaponSkill;
  String ballisticSkill;
  String strength;
  String toughness;
  String wounds;
  String attacks;
  String leadership;
  String save;

  StatItem({this.id, this.color, this.name, this.movement, this.weaponSkill, this.ballisticSkill, this.strength, this.toughness, this.wounds, this.attacks, this.leadership, this.save}) {
    if (this.id == 0) {
      this.imageText = null;
    } else {
      var splitName = this.name.split(' ');
      String imageText = '';
      for(var i = 0; i < splitName.length; i ++) {
        imageText += splitName[i][0];
      }
      this.imageText = imageText;
    }
  }
}