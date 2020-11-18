import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import '../classes/stat_item_list.dart';
import '../stat_avatar.dart';
import '../classes/army.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';
import '../db/database_helper.dart';

class AddArmy extends StatefulWidget {
  final Army army;
  const AddArmy({Key key, @required this.army}) : super(key: key);
  _AddArmyState createState() => _AddArmyState();
}

class _AddArmyState extends State<AddArmy> {
  StatItemList statItemList;
  List selectedItemList;
  RandomColor randomColor = RandomColor();
  @override
  void initState() {
    super.initState();
    // Get all StatItems from DB
      DatabaseHelper.instance.queryAll('statItem').then((result) {
      StatItemList dbStatItemList = StatItemList(result);

      setState(() {
        statItemList = dbStatItemList;
      });
    });
    // Get StatItems tied to this Army from DB
    DatabaseHelper.instance.specialQuery(widget.army.id).then((result) {
      List<StatItem> selectedStatItems = [];
      for (var i = 0; i < result.length; i ++) {
        selectedStatItems.add(StatItem(
          id: result[i]['statItemId'],
          color: result[i]['color'],
          name: result[i]['name'],
          movement: result[i]['movement'],
          ballisticSkill: result[i]['ballisticSkill'],
          weaponSkill: result[i]['weaponSkill'],
          strength: result[i]['strength'],
          toughness: result[i]['toughness'],
          save: result[i]['save'],
          leadership: result[i]['leadership'],
          attacks: result[i]['attacks'],
          wounds: result[i]['wounds']
        ));
      }
      setState(() {
        selectedItemList = selectedStatItems;
      });
    });
  }
  Widget build(BuildContext context) {
    dynamic name = '';
    if (statItemList == null || selectedItemList == null) {
      return Scaffold();
    } else {
      List selectedStatItems = selectedItemList;
      var filteredStatItemList = statItemList.filterList(selectedStatItems);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.army.name),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: selectedStatItems.length > 0 ? GridView.builder(
                    itemCount: selectedStatItems.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              StatItem removedAvatar = selectedStatItems.removeAt(index);
                              DatabaseHelper.instance.pivotDelete('armyStatItemPivot', removedAvatar.id, widget.army.id);
                              statItemList.statItemList.add(removedAvatar);
                            });
                          },
                          child: StatAvatar(
                              id: selectedStatItems[index].id,
                              imageText: selectedStatItems[index].imageText,
                              name: selectedStatItems[index].name,
                              color: selectedStatItems[index].color));
                    }) : Center(child: Text('Add units to the army by clicking the + or circles below.')),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey[800],
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredStatItemList.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filteredStatItemList[index].id == 0) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'What do you want to name your new stat item?'),
                                          content: TextField(
                                            decoration:
                                                InputDecoration(labelText: 'Name'),
                                            onChanged: (input) {
                                              name = input;
                                            },
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Create'),
                                              onPressed: () {
                                                String randomColorCode = getColorNameFromColor(randomColor.randomColor(colorBrightness: ColorBrightness.dark, colorHue: ColorHue.multiple(colorHues: [ColorHue.blue, ColorHue.green]))).getCode;
                                                StatItem newStatItem = StatItem(
                                                  name: name,
                                                  color: randomColorCode
                                                );
                                                setState(() {
                                                  DatabaseHelper.instance.insert('statItem', {'name': name, 'color': randomColorCode}).then((id) {
                                                    newStatItem.id = id;
                                                    DatabaseHelper.instance.insert('armyStatItemPivot', {'statItemId': newStatItem.id, 'armyId': widget.army.id});
                                                  });
                                                  selectedStatItems
                                                      .add(newStatItem);
                                                });
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddStatItem(
                                                      statItem: newStatItem,
                                                      isNew: true
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  StatItem removedAvatar = filteredStatItemList.removeAt(index);
                                  DatabaseHelper.instance.insert('armyStatItemPivot', {'statItemId': removedAvatar.id, 'armyId': widget.army.id});
                                  selectedStatItems.add(removedAvatar);
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              child: StatAvatar(
                                  id: filteredStatItemList[index].id,
                                  imageText: filteredStatItemList[index].imageText,
                                  name: filteredStatItemList[index].name,
                                  color: filteredStatItemList[index].color),
                            ),
                          );
                        }),
                  )),
            ],
          ),
        ),
      );

    }
  }
}
