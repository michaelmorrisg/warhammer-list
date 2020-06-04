import 'package:flutter/material.dart';
import 'stat_avatar_list.dart';
import 'army.dart';

class AddArmy extends StatefulWidget {
  final Army army;
  const AddArmy({Key key, @required this.army}) : super(key: key);
  _AddArmyState createState() => _AddArmyState();
}
class _AddArmyState extends State<AddArmy> {
  StatAvatarList statAvatarList = StatAvatarList();

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context).settings.arguments;
    print(widget.army.avatars);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.army.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Center(
              child: Wrap(
                children: <Widget>[

                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
          itemCount: statAvatarList.avatarList.length,
          itemBuilder: (BuildContext context, index) {
            return statAvatarList.getAvatars(index, context);
          }
        )
          ),
        ],
      ),
    );
  }
}
