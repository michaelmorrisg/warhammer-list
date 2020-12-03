import 'package:flutter/material.dart';
import 'add_army.dart';
import '../classes/army.dart';
import 'go_to_army.dart';
import '../db/database_helper.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List armyList;
  dynamic newName = '';
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.queryAll('army').then((result) {
      List<Army> newList = [];
      for (var i = 0; i < result.length; i++) {
        newList.add(
            Army(id: result[i]['id'], name: result[i]['name'], statItems: []));
      }
      setState(() {
        armyList = newList;
      });
    });
  }

  Widget build(BuildContext context) {
    if (armyList == null) {
      return Scaffold(
          body: Container(
        alignment: Alignment(0, 0),
        child: CircularProgressIndicator(),
      ));
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('What do you want to name your new list?'),
                    content: TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (input) {
                        newName = input;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Create'),
                        onPressed: () {
                          Army newArmy = Army(name: newName, statItems: []);
                          setState(() {
                            armyList.add(newArmy);
                          });

                          DatabaseHelper.instance
                              .insert('army', {'name': newName}).then((id) => {
                                    newArmy.id = id,
                                    Navigator.pop(context),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddArmy(
                                          army: newArmy,
                                        ),
                                      ),
                                    )
                                  });
                        },
                      ),
                    ],
                  );
                });
          }),
      body: armyList.length > 0
          ? Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ListView.builder(
                  itemCount: armyList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      child: ListTile(
                          title: Text(armyList[index].name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w700)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddArmy(
                                                army: armyList[index])));
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Delete List?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              FlatButton(
                                                textColor: Colors.red,
                                                child: Text('Delete'),
                                                onPressed: () {
                                                  setState(() {
                                                    DatabaseHelper.instance
                                                        .delete('army',
                                                            armyList[index].id);
                                                    DatabaseHelper.instance
                                                        .pivotDeleteArmy(
                                                            'armyStatItemPivot',
                                                            armyList[index].id);
                                                    armyList.removeAt(index);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GoToArmy(army: armyList[index])));
                          }),
                    );
                  }),
            )
          : Center(child: Text('You have no armies. Click the + to add one.')),
    );
  }
}
