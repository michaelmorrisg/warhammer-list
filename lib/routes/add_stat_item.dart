import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../db/database_helper.dart';
import '../classes/army.dart';
import 'go_to_army.dart';

class AddStatItem extends StatefulWidget {
  final StatItem statItem;
  final bool isNew;
  final Army currentArmy;
  const AddStatItem(
      {Key key,
      @required this.statItem,
      this.isNew,
      this.currentArmy})
      : super(key: key);
  _AddStatItemState createState() => _AddStatItemState();
}

class _AddStatItemState extends State<AddStatItem> {
  StatItem statItem;
  Army currentArmy;
  List<StatItem> selectedStatItems;

  initState() {
    statItem = widget.statItem;
    currentArmy = widget.currentArmy;
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
        body: Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Movement',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.movement,
                      decoration: InputDecoration(
                        hintText: 'M',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.movement = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Weapon Skill',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.weaponSkill,
                      decoration: InputDecoration(
                        hintText: 'WS',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.weaponSkill = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Ballistic Skill',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.ballisticSkill,
                      decoration: InputDecoration(
                        hintText: 'BS',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.ballisticSkill = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Strength',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.strength,
                      decoration: InputDecoration(
                        hintText: 'S',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.strength = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Toughness',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.toughness,
                      decoration: InputDecoration(
                        hintText: 'T',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.toughness = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Wounds',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.wounds,
                      decoration: InputDecoration(
                        hintText: 'W',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.wounds = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
          TableRow(children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Attacks',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.attacks,
                      decoration: InputDecoration(
                        hintText: 'A',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.attacks = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Leadership',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.leadership,
                      decoration: InputDecoration(
                        hintText: 'Ld',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.leadership = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: statItem.save,
                      decoration: InputDecoration(
                        hintText: 'Sv',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          statItem.save = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
