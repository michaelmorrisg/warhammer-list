import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';

class AvatarStats extends StatefulWidget {
  final StatItem statItem;
  const AvatarStats({Key key, @required this.statItem}) : super(key: key);
  _AvatarStatsState createState() => _AvatarStatsState();
}

class _AvatarStatsState extends State<AvatarStats> {
    StatItem statItem;

  initState() {
    statItem = widget.statItem;
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
                      isNew: false
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
          CellWidget(stat: statItem.movement, title: 'M'),
          CellWidget(stat: statItem.weaponSkill, title: 'WS'),
          CellWidget(stat: statItem.ballisticSkill, title: 'BS'),
        ]),
        TableRow(children: [
          CellWidget(stat: statItem.strength, title: 'S'),
          CellWidget(stat: statItem.toughness, title: 'T'),
          CellWidget(stat: statItem.wounds, title: 'W'),
        ]),
        TableRow(children: [
          CellWidget(stat: statItem.attacks, title: 'A'),
          CellWidget(stat: statItem.leadership, title: 'Ld'),
          CellWidget(stat: statItem.save, title: 'Sa'),
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
