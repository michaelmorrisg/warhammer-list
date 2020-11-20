import 'package:flutter/material.dart';
import 'avatar_stats.dart';
import '../stat_avatar.dart';
import '../classes/army.dart';
import '../db/database_helper.dart';
import '../classes/stat_item.dart';

class GoToArmy extends StatefulWidget {
  final Army army;
  const GoToArmy({Key key, @required this.army}) : super(key: key);
  _GoToArmyState createState() => _GoToArmyState();
}

class _GoToArmyState extends State<GoToArmy> {
  List selectedItemList;
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.specialQuery(widget.army.id).then((result) {
      List<StatItem> selectedStatItems = [];
      for (var i = 0; i < result.length; i++) {
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
            wounds: result[i]['wounds']));
      }
      setState(() {
        selectedItemList = selectedStatItems;
      });
    });
  }

  Widget build(BuildContext context) {
    if (selectedItemList == null) {
      return Scaffold();
    } else {
      List selectedStatItems = selectedItemList;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.army.name),
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
                                    currentArmy: widget.army,
                                  ),
                                ));
                          },
                          child: StatAvatar(
                              id: selectedStatItems[index].id,
                              imageText: selectedStatItems[index].imageText,
                              name: selectedStatItems[index].name,
                              color: selectedStatItems[index].color));
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}
