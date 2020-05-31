import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-army');
            }),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                  title: Text('Tzeentch Demons'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.edit),
                        onPressed: () {
                          print('edit!');
                        },
                      ),
                      FlatButton(
                          child: Icon(Icons.delete),
                          onPressed: () {
                            print('delete!');
                          }),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/add-army', arguments: 1);
                  }),
            ),
          ],
        ));
  }
}
