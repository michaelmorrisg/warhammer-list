import 'package:flutter/material.dart';
import '../classes/stat_item.dart';

class AvatarStats extends StatefulWidget {
  final StatItem statItem;
  const AvatarStats({Key key, @required this.statItem}) : super(key: key);
  _AvatarStatsState createState() => _AvatarStatsState();
}

class _AvatarStatsState extends State<AvatarStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.statItem.name)
      )
    );
  }
}
