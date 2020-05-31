import 'package:flutter/material.dart';
import 'stat_avatar.dart';

class AddArmy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Army $args'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: Text('AB'),
                    ),
                    label: Text('Aaron Burr'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                StatAvatar('Pink Horror', 'PH')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
