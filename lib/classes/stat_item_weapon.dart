class StatItemWeapon {
  int id;
  String name;
  String range;
  String type;
  String strength;
  String ap;
  String damage;
  String abilities;
  int statItemId;

  StatItemWeapon({this.id, this.name, this.range, this.type, this.strength, this.ap, this.damage, this.abilities, this.statItemId});

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'range': range,
      'type': type,
      'strength': strength,
      'ap': ap,
      'damage': damage,
      'abilities': abilities,
      'statItemId': statItemId
    };
  }
}