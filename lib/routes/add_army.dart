import 'package:flutter/material.dart';
import '../stat_item_list.dart';
import '../stat_avatar.dart';
import '../army.dart';
import '../stat_item.dart';

class AddArmy extends StatefulWidget {
  final Army army;
  const AddArmy({Key key, @required this.army}) : super(key: key);
  _AddArmyState createState() => _AddArmyState();
}

class _AddArmyState extends State<AddArmy> {
  StatItemList statItemList = StatItemList();
  @override
  Widget build(BuildContext context) {
    List selectedStatItems = widget.army.statItems;
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
                          name: selectedStatItems[index].name),
                    );
                  }),
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: statItemList.statItemList.length,
                    itemBuilder: (BuildContext context, index) {
                      // return statAvatarList.getAvatars(index, context);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            StatItem removedAvatar =
                                statItemList.statItemList.removeAt(index);
                            selectedStatItems.add(removedAvatar);
                          });
                        },
                        child: StatAvatar(
                            id: statItemList.statItemList[index].id,
                            imageText: statItemList.statItemList[index].imageText,
                            name: statItemList.statItemList[index].name),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
