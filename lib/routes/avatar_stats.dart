import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';

class AvatarStats extends StatefulWidget {
  final StatItem statItem;
  const AvatarStats({Key key, @required this.statItem}) : super(key: key);
  _AvatarStatsState createState() => _AvatarStatsState();
}

class _AvatarStatsState extends State<AvatarStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.statItem.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStatItem(
                      statItem: widget.statItem,
                      isNew: false
                    ),
                  ),
                );
              }),
        ],
      ),
      body: Table(border: TableBorder.all(), children: [
        TableRow(children: [
          CellWidget(stat: widget.statItem.movement, title: 'M'),
          CellWidget(stat: widget.statItem.weaponSkill, title: 'WS'),
          CellWidget(stat: widget.statItem.ballisticSkill, title: 'BS'),
        ]),
        TableRow(children: [
          CellWidget(stat: widget.statItem.strength, title: 'S'),
          CellWidget(stat: widget.statItem.toughness, title: 'T'),
          CellWidget(stat: widget.statItem.wounds, title: 'W'),
        ]),
        TableRow(children: [
          CellWidget(stat: widget.statItem.attacks, title: 'A'),
          CellWidget(stat: widget.statItem.leadership, title: 'Ld'),
          CellWidget(stat: widget.statItem.save, title: 'Sa'),
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
