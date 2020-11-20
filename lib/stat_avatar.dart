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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color(int.parse('0xFF${this.color}')),
            radius: 30.0,
            child: this.imageText != null ? Text(this.imageText) : Icon(Icons.add),
          ),
          Text(name)
        ],
      ),
    );
  }
}
