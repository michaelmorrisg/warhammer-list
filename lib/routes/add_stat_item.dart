import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../db/database_helper.dart';
import '../classes/army.dart';
import 'go_to_army.dart';
import '../classes/stat_item_weapon.dart';

class AddStatItem extends StatefulWidget {
  final StatItem statItem;
  final bool isNew;
  final Army currentArmy;
  const AddStatItem(
      {Key key, @required this.statItem, this.isNew, this.currentArmy})
      : super(key: key);
  _AddStatItemState createState() => _AddStatItemState();
}

class _AddStatItemState extends State<AddStatItem> {
  StatItem statItem;
  Army currentArmy;
  StatItemWeapon newWeapon;
  List<StatItem> selectedStatItems;

  initState() {
    statItem = widget.statItem;
    currentArmy = widget.currentArmy;
    newWeapon = StatItemWeapon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DatabaseHelper.instance.update('statItem', statItem.toMap());
        Navigator.pop(context, statItem);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.isNew ? 'Add ${statItem.name}' : 'Edit ${statItem.name}'),
          actions: !widget.isNew
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Are you sure you want to delete this unit?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Delete'),
                                  onPressed: () async {
                                    await DatabaseHelper.instance
                                        .delete('statItem', statItem.id);
                                    await DatabaseHelper.instance
                                        .pivotDeleteStatItem(
                                            'armyStatItemPivot', statItem.id);
                                    // Feels like there should be something better than this...
                                    Navigator.pop(context);
                                    Navigator.pop(context, statItem);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GoToArmy(army: currentArmy)));
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  )
                ]
              : <Widget>[],
        ),
        body: ListView(children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.movement,
                        decoration: InputDecoration(
                          labelText: 'Movement',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.movement = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.weaponSkill,
                        decoration: InputDecoration(
                          labelText: 'Weapon Skill',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.weaponSkill = text;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.ballisticSkill,
                        decoration: InputDecoration(
                          labelText: 'Ballistic Skill',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.ballisticSkill = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.strength,
                        decoration: InputDecoration(
                          labelText: 'Strength',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.strength = text;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.toughness,
                        decoration: InputDecoration(
                          labelText: 'Toughness',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.toughness = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.wounds,
                        decoration: InputDecoration(
                          labelText: 'Wounds',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.wounds = text;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.attacks,
                        decoration: InputDecoration(
                          labelText: 'Attacks',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.attacks = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.leadership,
                        decoration: InputDecoration(
                          labelText: 'Leadership',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.leadership = text;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        initialValue: statItem.save,
                        decoration: InputDecoration(
                          labelText: 'Save',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            statItem.save = text;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    newWeapon = StatItemWeapon();
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('New Weapon'),
                            content: Container(
                              width: double.maxFinite,
                              child: ListView(
                                children: [
                                  TextFormField(
                                    initialValue: newWeapon.name,
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.name = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.range,
                                    decoration:
                                        InputDecoration(labelText: 'Range'),
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.range = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.type,
                                    decoration:
                                        InputDecoration(labelText: 'Type'),
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.type = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.strength,
                                    decoration:
                                        InputDecoration(labelText: 'Strength'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.strength = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.ap,
                                    decoration: InputDecoration(labelText: 'AP'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.ap = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.damage,
                                    decoration:
                                        InputDecoration(labelText: 'Damage'),
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.damage = text;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: newWeapon.abilities,
                                    decoration: InputDecoration(
                                      labelText: 'Abilities',
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        newWeapon.abilities = text;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('Create'),
                                onPressed: () {
                                  newWeapon.statItemId = widget.statItem.id;
                                  DatabaseHelper.instance.insert(
                                      'statItemWeapon', newWeapon.toMap());
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('+ Weapon',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xFFFFAB00))),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
