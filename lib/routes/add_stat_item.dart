import 'package:flutter/material.dart';
import '../classes/stat_item.dart';

class AddStatItem extends StatefulWidget {
  final StatItem statItem;
  const AddStatItem({Key key, @required this.statItem}) : super(key: key);
  _AddStatItemState createState() => _AddStatItemState(); 
}

class _AddStatItemState extends State<AddStatItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Stat Item')),
    );
  }
}