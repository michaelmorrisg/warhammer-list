import 'package:flutter/material.dart';

class StatAvatar extends StatelessWidget {
  final id;
  final name;
  final imageText;
  final color;

  StatAvatar({this.name, this.imageText, this.id, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: this.color,
            radius: 40.0,
            child: this.imageText != '+' ? Text(this.imageText) : Icon(Icons.add),
          ),
          Text(name)
        ],
      ),
    );
  }
}
