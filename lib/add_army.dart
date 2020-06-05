import 'package:flutter/material.dart';
import 'stat_avatar_list.dart';
import 'stat_avatar.dart';
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
    List selectedAvatars = widget.army.avatars;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.army.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: selectedAvatars.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        StatAvatar removedAvatar = selectedAvatars.removeAt(index);
                        statAvatarList.avatarList.add(removedAvatar);
                      });
                    },
                    child: StatAvatar(
                        id: selectedAvatars[index].id,
                        imageText: selectedAvatars[index].imageText,
                        name: selectedAvatars[index].name),
                  );
                }),
          ),
          Expanded(
              flex: 1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: statAvatarList.avatarList.length,
                  itemBuilder: (BuildContext context, index) {
                    // return statAvatarList.getAvatars(index, context);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          StatAvatar removedAvatar = statAvatarList.avatarList.removeAt(index);
                          selectedAvatars.add(removedAvatar);
                        });
                      },
                      child: StatAvatar(
                          id: statAvatarList.avatarList[index].id,
                          imageText: statAvatarList.avatarList[index].imageText,
                          name: statAvatarList.avatarList[index].name
                        ),
                    );
                  })),
        ],
      ),
    );
  }
}
