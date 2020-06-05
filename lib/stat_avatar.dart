import 'package:flutter/material.dart';

class StatAvatar extends StatelessWidget {
  final id;
  final name;
  final imageText;

  StatAvatar({this.name, this.imageText, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.pink,
            radius: 40.0,
            child: Text(this.imageText),
          ),
          Text(name)
        ],
      ),
    );
  }
}
