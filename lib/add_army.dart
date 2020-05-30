import 'package:flutter/material.dart';

class AddArmy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Army'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Back to Main'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}