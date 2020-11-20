import 'package:flutter/material.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';
import '../classes/army.dart';

class AvatarStats extends StatefulWidget {
  final StatItem statItem;
  final Army currentArmy;
  const AvatarStats({Key key, @required this.statItem, this.currentArmy})
      : super(key: key);
  _AvatarStatsState createState() => _AvatarStatsState();
}

class _AvatarStatsState extends State<AvatarStats> {
  StatItem statItem;
  Army currentArmy;
  List<StatItem> selectedStatItems;
  List<Map> dummyData = [
    {'test': 'yeay'},
    {'wut': 'wut'},
    {},
    {}
  ];

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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        // margin: EdgeInsets.only(left: 40.0),
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))),
                        child: Text(statItem.name)),
                  ],
                ),
                Table(children: [
                  TableRow(children: [
                    CellWidget(
                      stat: statItem.movement == null
                          ? '-'
                          : statItem.movement + '"',
                      title: 'M',
                      roundedCorner: 'left',
                    ),
                    CellWidget(
                        stat: statItem.weaponSkill == null
                            ? '-'
                            : statItem.weaponSkill + '+',
                        title: 'WS'),
                    CellWidget(
                        stat: statItem.ballisticSkill == null
                            ? '-'
                            : statItem.ballisticSkill + '+',
                        title: 'BS'),
                    CellWidget(
                        stat:
                            statItem.strength == null ? '-' : statItem.strength,
                        title: 'S'),
                    CellWidget(
                        stat: statItem.toughness == null
                            ? '-'
                            : statItem.toughness,
                        title: 'T'),
                    CellWidget(
                        stat: statItem.wounds == null ? '-' : statItem.wounds,
                        title: 'W'),
                    CellWidget(
                        stat: statItem.attacks == null ? '-' : statItem.attacks,
                        title: 'A'),
                    CellWidget(
                        stat: statItem.leadership == null
                            ? '-'
                            : statItem.leadership,
                        title: 'Ld'),
                    CellWidget(
                      stat: statItem.save == null ? '-' : statItem.save + '+',
                      title: 'Sa',
                      roundedCorner: 'right',
                    ),
                  ]),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: [
                Text('Weapons'),
              ],
            ),
          ),
          for (var i = 0; i < dummyData.length; i++)
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          // margin: EdgeInsets.only(left: 40.0),
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          child: Text(statItem.name)),
                    ],
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        CellWidget(
                          stat: '',
                          title: 'Range',
                          roundedCorner: 'left',
                        ),
                        CellWidget(stat: '', title: 'Type'),
                        CellWidget(stat: '', title: 'S'),
                        CellWidget(stat: '', title: 'AP'),
                        CellWidget(
                          stat: '',
                          title: 'D',
                          roundedCorner: 'right',
                        ),
                      ])
                    ],
                  ),
                  Table(children: [TableRow(children: [
                    CellWidget(stat: '', title: 'Abilities')
                  ]),],)
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  final stat;
  final title;
  final roundedCorner;

  CellWidget({this.stat, this.title, this.roundedCorner});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: this.roundedCorner == 'right'
                    ? BorderRadius.only(topRight: Radius.circular(10.0))
                    : null,
                color: Colors.blueGrey),
            child: Text(
              this.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: this.roundedCorner == 'left'
                  ? Border(
                      bottom: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                    )
                  : this.roundedCorner == 'right'
                      ? Border(
                          bottom: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        )
                      : Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Text(
              this.stat,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
