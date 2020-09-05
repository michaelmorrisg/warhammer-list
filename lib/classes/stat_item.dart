import 'package:flutter/material.dart';

class StatItem {
  int id;
  int color;
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
  Color displayColor;

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
    if (this.color != null) {
      print(this.color);
      this.displayColor = Color(this.color);
    } else {
      this.displayColor = Colors.blue;
    }
  }
}