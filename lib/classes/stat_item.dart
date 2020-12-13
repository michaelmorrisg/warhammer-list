class StatItem {
  int id;
  String color;
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
  String abilities;
  dynamic degrades;
  String damageTable;

  StatItem({this.id, this.color, this.name, this.movement, this.weaponSkill, this.ballisticSkill, this.strength, this.toughness, this.wounds, this.attacks, this.leadership, this.save, this.abilities, this.degrades, this.damageTable}) {
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
    if (this.degrades == 1) {
      this.degrades = true;
    } else {
      this.degrades = false;
    }
  }

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'name': name,
      'imageText': imageText,
      'movement': movement,
      'weaponSkill': weaponSkill,
      'ballisticSkill': ballisticSkill,
      'strength': strength,
      'toughness': toughness,
      'wounds': wounds,
      'attacks': attacks,
      'leadership': leadership,
      'save': save,
      'abilities': abilities,
      'degrades': degrades == true ? 1 : 0,
      'damageTable': damageTable
    };
  }
}