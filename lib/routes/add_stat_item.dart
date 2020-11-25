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
  final List<StatItemWeapon> statItemWeapons;
  const AddStatItem(
      {Key key,
      @required this.statItem,
      this.isNew,
      this.currentArmy,
      this.statItemWeapons})
      : super(key: key);
  _AddStatItemState createState() => _AddStatItemState();
}

class _AddStatItemState extends State<AddStatItem> {
  StatItem statItem;
  Army currentArmy;
  StatItemWeapon newWeapon;
  List<StatItem> selectedStatItems;
  List<StatItemWeapon> statItemWeapons;

  initState() {
    statItem = widget.statItem;
    currentArmy = widget.currentArmy;
    newWeapon = StatItemWeapon();
    statItemWeapons =
        widget.statItemWeapons != null ? widget.statItemWeapons : [];
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
                                FlatButton(child: Text('Cancel'), onPressed: () {
                                  Navigator.pop(context);
                                },),
                                FlatButton(
                                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.instance
                                        .delete('statItem', statItem.id);
                                    await DatabaseHelper.instance
                                        .pivotDeleteStatItem(
                                            'armyStatItemPivot', statItem.id)
                                        .then((returnValue) {});
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: [
                    Text('Unit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xFFFFAB00))),
                  ],
                ),
              ),
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
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: statItemWeapons.length > 0
                ? Row(
                    children: [
                      Text('Weapons',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xFFFFAB00))),
                    ],
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              children: [
                for (var i = 0; i < statItemWeapons.length; i++)
                  GestureDetector(
                      onTap: () {
                        StatItemWeapon editStatItemWeapon = statItemWeapons[i];
                        Map statItemWeaponCopy = editStatItemWeapon.toMap();
                        bool weaponSaved = false;
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Edit ${editStatItemWeapon.name}'),
                                    GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Delete Weapon'),
                                                  content: Text(
                                                      'Are you sure you want to delete this weapon?'),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                                      onPressed: () {
                                                        DatabaseHelper.instance.delete('statItemWeapon', editStatItemWeapon.id).then((result) {
                                                          setState(() {
                                                            statItemWeapons.removeWhere((weapon) => weapon.id == editStatItemWeapon.id);
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                                content: Container(
                                  width: double.maxFinite,
                                  child: ListView(
                                    children: [
                                      TextFormField(
                                        initialValue: editStatItemWeapon.name,
                                        decoration:
                                            InputDecoration(labelText: 'Name'),
                                        onChanged: (text) {
                                          setState(() {
                                            editStatItemWeapon.name = text;
                                          });
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 5.0),
                                              child: TextFormField(
                                                initialValue:
                                                    editStatItemWeapon.range,
                                                decoration: InputDecoration(
                                                    labelText: 'Range'),
                                                onChanged: (text) {
                                                  setState(() {
                                                    editStatItemWeapon.range =
                                                        text;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: TextFormField(
                                                initialValue:
                                                    editStatItemWeapon.type,
                                                decoration: InputDecoration(
                                                    labelText: 'Type'),
                                                onChanged: (text) {
                                                  setState(() {
                                                    editStatItemWeapon.type =
                                                        text;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 5.0),
                                              child: TextFormField(
                                                initialValue:
                                                    editStatItemWeapon.strength,
                                                decoration: InputDecoration(
                                                    labelText: 'Strength'),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (text) {
                                                  setState(() {
                                                    editStatItemWeapon
                                                        .strength = text;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: TextFormField(
                                                initialValue:
                                                    editStatItemWeapon.ap,
                                                decoration: InputDecoration(
                                                    labelText: 'AP'),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (text) {
                                                  setState(() {
                                                    editStatItemWeapon.ap =
                                                        text;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        initialValue: editStatItemWeapon.damage,
                                        decoration: InputDecoration(
                                            labelText: 'Damage'),
                                        onChanged: (text) {
                                          setState(() {
                                            editStatItemWeapon.damage = text;
                                          });
                                        },
                                      ),
                                      TextFormField(
                                        initialValue:
                                            editStatItemWeapon.abilities,
                                        decoration: InputDecoration(
                                          labelText: 'Abilities',
                                        ),
                                        onChanged: (text) {
                                          setState(() {
                                            editStatItemWeapon.abilities = text;
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
                                    child: Text('Save'),
                                    onPressed: () {
                                      weaponSaved = true;
                                      editStatItemWeapon.statItemId =
                                          statItem.id;
                                      DatabaseHelper.instance.update(
                                          'statItemWeapon',
                                          editStatItemWeapon.toMap());

                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            }).then((val) => {
                              if (weaponSaved == false)
                                {
                                  setState(() {
                                    editStatItemWeapon.name =
                                        statItemWeaponCopy['name'];
                                    editStatItemWeapon.range =
                                        statItemWeaponCopy['range'];
                                    editStatItemWeapon.type =
                                        statItemWeaponCopy['type'];
                                    editStatItemWeapon.strength =
                                        statItemWeaponCopy['strength'];
                                    editStatItemWeapon.ap =
                                        statItemWeaponCopy['ap'];
                                    editStatItemWeapon.damage =
                                        statItemWeaponCopy['damage'];
                                    editStatItemWeapon.abilities =
                                        statItemWeaponCopy['abilities'];
                                  })
                                }
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey[300],
                              radius: 30.0,
                              child: Icon(Icons.flare),
                            ),
                            Text(statItemWeapons[i].name != null
                                ? statItemWeapons[i].name
                                : 'none')
                          ],
                        ),
                      ))
              ],
            ),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: TextFormField(
                                            initialValue: newWeapon.range,
                                            decoration: InputDecoration(
                                                labelText: 'Range'),
                                            onChanged: (text) {
                                              setState(() {
                                                newWeapon.range = text;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: TextFormField(
                                            initialValue: newWeapon.type,
                                            decoration: InputDecoration(
                                                labelText: 'Type'),
                                            onChanged: (text) {
                                              setState(() {
                                                newWeapon.type = text;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: TextFormField(
                                            initialValue: newWeapon.strength,
                                            decoration: InputDecoration(
                                                labelText: 'Strength'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (text) {
                                              setState(() {
                                                newWeapon.strength = text;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: TextFormField(
                                            initialValue: newWeapon.ap,
                                            decoration: InputDecoration(
                                                labelText: 'AP'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (text) {
                                              setState(() {
                                                newWeapon.ap = text;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
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
                                  DatabaseHelper.instance
                                      .insert(
                                          'statItemWeapon', newWeapon.toMap())
                                      .then((returnValue) => setState(() =>
                                          statItemWeapons.add(newWeapon)));
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
