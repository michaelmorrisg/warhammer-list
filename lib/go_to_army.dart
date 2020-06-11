import 'package:flutter/material.dart';
import 'package:warhammerApp/avatar_stats.dart';
import 'stat_item_list.dart';
import 'stat_avatar.dart';
import 'army.dart';
import 'avatar_stats.dart';

class GoToArmy extends StatefulWidget {
  final Army army;
  const GoToArmy({Key key, @required this.army}) : super(key: key);
  _GoToArmyState createState() => _GoToArmyState();
}

class _GoToArmyState extends State<GoToArmy> {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AvatarStats(
                                statItem: selectedStatItems[index],
                              ),
                            ));
                      },
                      child: StatAvatar(
                          id: selectedStatItems[index].id,
                          imageText: selectedStatItems[index].imageText,
                          name: selectedStatItems[index].name),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
