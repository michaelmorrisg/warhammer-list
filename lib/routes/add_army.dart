import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import '../classes/stat_item_list.dart';
import '../stat_avatar.dart';
import '../classes/army.dart';
import '../classes/stat_item.dart';
import '../routes/add_stat_item.dart';
import '../routes/import_army.dart';
import '../db/database_helper.dart';

class AddArmy extends StatefulWidget {
  final Army army;
  const AddArmy({Key key, @required this.army}) : super(key: key);
  _AddArmyState createState() => _AddArmyState();
}

class _AddArmyState extends State<AddArmy> {
  StatItemList statItemList;
  List selectedItemList;
  RandomColor randomColor = RandomColor();
  List armyOptions = [
    {'title': 'Aeldari - Craftworlds', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Aeldari - Drukhari', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Aeldari - FW Corsairs', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Aeldari - Harlequins', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Aeldari - Ynnari', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Chaos Knights', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Chaos Space Marines', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Daemons', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Death Guard', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - FW Heretic Astartes', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Renegades', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Gellerpox Infected', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Servants of the Abyss', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Thousand Sons', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Chaos - Chaos Titan Legions', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Fallen', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adepta Sororitas', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astra Telepathica', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Custodes', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Mechanicus', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Astra Militarum - Library', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Astra Militarum', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Black Templars', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Blackstone Fortress', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Blood Angels', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Dark Angels', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Deathwatch', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Elucidian Starstriders', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - FW Adeptus Astartes', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Death Korps of Krieg', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Elysian Drop Troops', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Grey Knights', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Imperial Fists', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Imperial Knights', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Inquisition', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Iron Hands', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Legion of the Damned', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Officio Assassinorum', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Raven Guard', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Salamanders', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Sisters of Silence', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Space Marines', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Space Wolves', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Titan Legions', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - Ultramarines', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Imperium - Adeptus Astartes - White Scars', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Necrons', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Orks', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Tau Empire', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Tyranids - Genestealer Cults', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Tyranids', 'filePath': './wh40k/Chaos - Daemons.cat'},
    {'title': 'Unaligned - Monsters and Gribblies', 'filePath': './wh40k/Chaos - Daemons.cat'},
  ];
  var _importArmy;
  @override
  void initState() {
    super.initState();
    // Get all StatItems from DB
    DatabaseHelper.instance.queryAll('statItem').then((result) {
      StatItemList dbStatItemList = StatItemList(result);

      setState(() {
        statItemList = dbStatItemList;
      });
    });
    // Get StatItems tied to this Army from DB
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
            wounds: result[i]['wounds'],
            degrades: result[i]['degrades'],
            damageTable: result[i]['damageTable']));
      }
      setState(() {
        selectedItemList = selectedStatItems;
      });
    });
  }

  Widget build(BuildContext context) {
    dynamic name = '';
    if (statItemList == null || selectedItemList == null) {
      return Scaffold();
    } else {
      List selectedStatItems = selectedItemList;
      var filteredStatItemList = statItemList.filterList(selectedStatItems);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.army.name),
          actions: [
            IconButton(
              icon: Icon(Icons.import_export),
              onPressed: () async {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                          builder: (context, StateSetter setState) {
                        return AlertDialog(
                          title: Text('Choose an army to import from'),
                          content: Container(
                            width: double.maxFinite,
                            child: ListView(
                              children: [
                                for (var i = 0; i < armyOptions.length; i ++) 
                                RadioListTile(
                                    title: Text(armyOptions[i]['title']),
                                    value: armyOptions[i],
                                    groupValue: _importArmy,
                                    activeColor: Color(0xFFFFAB00),
                                    onChanged: (value) {
                                      setState(() {
                                        _importArmy = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Color(0xFFFFAB00),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImportArmy(army: _importArmy)));
                              },
                            ),
                          ],
                        );
                      });
                    });
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: selectedStatItems.length > 0
                  ? GridView.builder(
                      itemCount: selectedStatItems.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                StatItem removedAvatar =
                                    selectedStatItems.removeAt(index);
                                DatabaseHelper.instance.pivotDelete(
                                    'armyStatItemPivot',
                                    removedAvatar.id,
                                    widget.army.id);
                                statItemList.statItemList.add(removedAvatar);
                              });
                            },
                            child: StatAvatar(
                                id: selectedStatItems[index].id,
                                imageText: selectedStatItems[index].imageText,
                                name: selectedStatItems[index].name,
                                color: selectedStatItems[index].color));
                      })
                  : Center(
                      child: Text(
                        'Add units to the army by clicking the \'+\' or circles below.',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 6.0),
                          blurRadius: 20.0,
                        )
                      ]),
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
                                            'What do you want to name your new unit?'),
                                        content: TextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          decoration: InputDecoration(
                                              labelText: 'Name'),
                                          onChanged: (input) {
                                            name = input;
                                          },
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'Create',
                                              style: TextStyle(
                                                color: Color(0xFFFFAB00),
                                              ),
                                            ),
                                            onPressed: () {
                                              String randomColorCode =
                                                  getColorNameFromColor(
                                                      randomColor.randomColor(
                                                          colorBrightness:
                                                              ColorBrightness
                                                                  .light,
                                                          colorHue:
                                                              ColorHue.multiple(
                                                                  colorHues: [
                                                                ColorHue.blue
                                                              ]))).getCode;
                                              StatItem newStatItem = StatItem(
                                                  name: name,
                                                  color: randomColorCode);
                                              setState(() {
                                                DatabaseHelper.instance.insert(
                                                    'statItem', {
                                                  'name': name,
                                                  'color': randomColorCode
                                                }).then((id) {
                                                  newStatItem.id = id;
                                                  DatabaseHelper.instance
                                                      .insert(
                                                          'armyStatItemPivot', {
                                                    'statItemId':
                                                        newStatItem.id,
                                                    'armyId': widget.army.id
                                                  });
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
                                                          isNew: true),
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
                                DatabaseHelper.instance.insert(
                                    'armyStatItemPivot', {
                                  'statItemId': removedAvatar.id,
                                  'armyId': widget.army.id
                                });
                                selectedStatItems.add(removedAvatar);
                              }
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: StatAvatar(
                                id: filteredStatItemList[index].id,
                                imageText:
                                    filteredStatItemList[index].imageText,
                                name: filteredStatItemList[index].name,
                                color: filteredStatItemList[index].color),
                          ),
                        );
                      }),
                )),
          ],
        ),
      );
    }
  }
}
