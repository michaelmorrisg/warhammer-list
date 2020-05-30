import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Screen'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-army');
            }),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('List Item'),
                trailing: Icon(Icons.edit),
                onTap: () {
                  Navigator.pushNamed(context, '/add-army');
                }
              ),
            ),
            Card(
              child: ListTile(
                title: Text('List Item'),
                trailing: Icon(Icons.edit),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('List Item'),
                trailing: Icon(Icons.edit),
              ),
            ),
          ],
        ));
  }
}
