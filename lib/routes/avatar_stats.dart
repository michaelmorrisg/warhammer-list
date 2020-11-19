import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';
import '../classes/army.dart';

class AvatarStats extends StatefulWidget {
  final StatItem statItem;
  final Army currentArmy;
  const AvatarStats({Key key, @required this.statItem, this.currentArmy}) : super(key: key);
  _AvatarStatsState createState() => _AvatarStatsState();
}

class _AvatarStatsState extends State<AvatarStats> {
    StatItem statItem;
    Army currentArmy;
    List<StatItem>selectedStatItems;

  initState() {
    statItem = widget.statItem;
    currentArmy = widget.currentArmy;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(statItem.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                StatItem updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStatItem(
                      statItem: statItem,
                      isNew: false,
                      currentArmy: currentArmy,
                    ),
                  ),
                );
                setState(() {
                  statItem = updatedData;
                });
              }),
        ],
      ),
      body: Table(border: TableBorder.all(), children: [
        TableRow(children: [
          CellWidget(stat: statItem.movement == null ? '0' : statItem.movement, title: 'M'),
          CellWidget(stat: statItem.weaponSkill == null ? '0' : statItem.weaponSkill, title: 'WS'),
          CellWidget(stat: statItem.ballisticSkill == null ? '0' : statItem.ballisticSkill, title: 'BS'),
        ]),
        TableRow(children: [
          CellWidget(stat: statItem.strength == null ? '0' : statItem.strength, title: 'S'),
          CellWidget(stat: statItem.toughness == null ? '0' : statItem.toughness, title: 'T'),
          CellWidget(stat: statItem.wounds == null ? '0' : statItem.wounds, title: 'W'),
        ]),
        TableRow(children: [
          CellWidget(stat: statItem.attacks == null ? '0' : statItem.attacks, title: 'A'),
          CellWidget(stat: statItem.leadership == null ? '0' : statItem.leadership, title: 'Ld'),
          CellWidget(stat: statItem.save == null ? '0' : statItem.save, title: 'Sa'),
        ]),
      ]),
    );
  }
}

class CellWidget extends StatelessWidget {
  final stat;
  final title;

  CellWidget({this.stat, this.title});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Text(
              this.title,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(stat, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
