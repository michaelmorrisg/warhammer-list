import 'package:flutter/material.dart';
import 'package:warhammerApp/classes/stat_item_weapon.dart';
import 'package:warhammerApp/db/database_helper.dart';
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
  List<StatItemWeapon> statItemWeapons = [];

  initState() {
    statItem = widget.statItem;
    currentArmy = widget.currentArmy;

    super.initState();
    DatabaseHelper.instance
        .queryStatItemWeapon('statItemWeapon', statItem.id)
        .then((result) => {
              result.forEach((result) {
                statItemWeapons.add(StatItemWeapon(
                    id: result['id'],
                    name: result['name'],
                    range: result['range'],
                    type: result['type'],
                    damage: result['damage'],
                    ap: result['ap'],
                    strength: result['strength'],
                    abilities: result['abilities']));
              }),
              setState(() {
                statItemWeapons = statItemWeapons;
              })
            });
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Text('Unit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xFFFFAB00))),
                    ],
                  ),
                ),
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
                                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Abilities',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 5.0, 10.0, 5.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          statItem.abilities == null
                                              ? '-'
                                              : statItem.abilities),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              children: [
                Text('Weapons',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color(0xFFFFAB00))),
              ],
            ),
          ),
          for (var i = 0; i < statItemWeapons.length; i++)
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
                          child: Text(statItemWeapons[i].name == null
                              ? ''
                              : statItemWeapons[i].name)),
                    ],
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        CellWidget(
                            stat: statItemWeapons[i].range == null
                                ? '-'
                                : statItemWeapons[i].range,
                            title: 'Range',
                            roundedCorner: 'left'),
                        CellWidget(
                            stat: statItemWeapons[i].type == null
                                ? '-'
                                : statItemWeapons[i].type,
                            title: 'Type'),
                        CellWidget(
                            stat: statItemWeapons[i].strength == null
                                ? '-'
                                : statItemWeapons[i].strength,
                            title: 'S'),
                        CellWidget(
                            stat: statItemWeapons[i].ap == null
                                ? '-'
                                : statItemWeapons[i].ap,
                            title: 'AP'),
                        CellWidget(
                          stat: statItemWeapons[i].damage == null
                              ? '-'
                              : statItemWeapons[i].damage,
                          title: 'D',
                          roundedCorner: 'right',
                        ),
                      ])
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Abilities',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 5.0, 10.0, 5.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          statItemWeapons[i].abilities == null
                                              ? '-'
                                              : statItemWeapons[i].abilities),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
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
  final overrideColor;

  CellWidget(
      {this.stat, this.title, this.roundedCorner, this.overrideColor = false});
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            decoration: BoxDecoration(
                borderRadius: this.roundedCorner == 'right'
                    ? BorderRadius.only(topRight: Radius.circular(10.0))
                    : null,
                color:
                    overrideColor != false ? overrideColor : Colors.blueGrey),
            child: Text(
              this.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
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
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
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
