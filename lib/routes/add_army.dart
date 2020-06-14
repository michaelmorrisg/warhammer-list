import 'package:flutter/material.dart';
import '../classes/stat_item_list.dart';
import '../stat_avatar.dart';
import '../classes/army.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';

class AddArmy extends StatefulWidget {
  final Army army;
  const AddArmy({Key key, @required this.army}) : super(key: key);
  _AddArmyState createState() => _AddArmyState();
}

class _AddArmyState extends State<AddArmy> {
  StatItemList statItemList = StatItemList();
  @override
  Widget build(BuildContext context) {
    dynamic name = '';
    List selectedStatItems = widget.army.statItems;
    // for (var i = 0; i < selectedStatItems.length; i ++) {
    //   statItemList.removeWhere((statItem) => statItem)
    // }
    var filteredStatItemList = statItemList.filterList(selectedStatItems);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.army.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
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
                            color: selectedStatItems[index].color));
                  }),
            ),
            Expanded(
                flex: 1,
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
                                                id: 6, color: Colors.cyan, );
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddStatItem(
                                                  statItem: newStatItem,
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
                            color: filteredStatItemList[index].color),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
