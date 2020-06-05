import 'package:flutter/material.dart';
import 'stat_avatar.dart';

class StatAvatarList {
  List<StatAvatar> avatarList = [
    StatAvatar(id: 1, imageText: 'PH', name: 'Pink Horror'),
    StatAvatar(id: 2, imageText: 'BH', name: 'Blue Horror'),
    StatAvatar(id: 3, imageText: 'F', name: 'Flamer'),
    StatAvatar(id: 4, imageText: 'LOC', name: 'Lord of Change'),
    StatAvatar(id: 5, imageText: 'DP', name: 'Demon Prince'),
  ];

  StatAvatar getAvatars(index, context) {
    return avatarList[index];
  }
}
