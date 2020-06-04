import 'package:flutter/material.dart';
import 'stat_avatar.dart';

class StatAvatarList {
  List<StatAvatar> avatarList = [
    StatAvatar(imageText: 'PH', name: 'Pink Horror'),
    StatAvatar(imageText: 'BH', name: 'Blue Horror'),
    StatAvatar(imageText: 'F', name: 'Flamer'),
    StatAvatar(imageText: 'LOC', name: 'Lord of Change'),
    StatAvatar(imageText: 'DP', name: 'Demon Prince'),
  ];

  StatAvatar getAvatars(index, context) {
    return avatarList[index];
  }
}
