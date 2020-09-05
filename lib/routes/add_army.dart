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
  // StatItemList statItemList = StatItemList();
  StatItemList statItemList;
  RandomColor randomColor = RandomColor();
  @override
  void initState() {
    super.initState();
      DatabaseHelper.instance.queryAll('statItem').then((result) {
        print(result);
      StatItemList dbStatItemList = StatItemList(result);

      setState(() {
        statItemList = dbStatItemList;
      });
    });
  }
  Widget build(BuildContext context) {
    dynamic name = '';
    List selectedStatItems = widget.army.statItems;
    if (statItemList == null) {
      return Scaffold();
    } else {
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
                flex: 6,
                child: GridView.builder(
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
                              StatItem removedAvatar =
                                  selectedStatItems.removeAt(index);
                              statItemList.statItemList.add(removedAvatar);
                            });
                          },
                          child: StatAvatar(
                              id: selectedStatItems[index].id,
                              imageText: selectedStatItems[index].imageText,
                              name: selectedStatItems[index].name,
                              color: selectedStatItems[index].displayColor));
                    }),
              ),
              Expanded(
                  flex: 2,
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
                                              StatItem newStatItem = StatItem(
                                                  name: name,
                                                  color: 4292149248
                                                  // randomColor.randomColor(
                                                  //     colorSaturation:
                                                  //         ColorSaturation
                                                  //             .highSaturation)
                                                              );
                                              setState(() {
                                                // make this go to DB as well?
                                                DatabaseHelper.instance.insert('statItem', {'name': name, 'color': 4292149248}).then((id) => {
                                                  newStatItem.id = id
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
                                StatItem removedAvatar =
                                    filteredStatItemList.removeAt(index);
                                selectedStatItems.add(removedAvatar);
                              }
                            });
                          },
                          child: StatAvatar(
                              id: filteredStatItemList[index].id,
                              imageText: filteredStatItemList[index].imageText,
                              name: filteredStatItemList[index].name,
                              color: filteredStatItemList[index].displayColor),
                        );
                      })),
            ],
          ),
        ),
      );

    }
  }
}
