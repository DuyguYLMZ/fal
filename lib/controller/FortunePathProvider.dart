import 'dart:convert';

import 'package:example/model/fortune.dart';
import 'package:example/model/user.dart';
import 'package:flutter/cupertino.dart';

class FortunePathProvider extends ChangeNotifier {
  late int _videoIndex;

  late String _imagePath;
  late List<UserPhoneInfo> userList;
  late List<Fortune> fortuneList;
  Map<int, String> fortuneImageMap = {1: '', 2: '', 3: ''};
  List widgets = <Widget>[];

  String get fortuneImagePath => _imagePath;

  int get index => _videoIndex;
  void setVideoIndex(int i){
    this._videoIndex =i;
  }

  void setImagePath(String value, int btnId) {
    switch (btnId) {
      case 1:
        fortuneImageMap[btnId] = value;
        break;
      case 2:
        fortuneImageMap[btnId] = value;
        break;
      case 3:
        fortuneImageMap[btnId] = value;
        break;
    }
    this._imagePath = value;
  }
  void setFortunePathEmpty() {
    this.fortuneImageMap = {1: '', 2: '', 3: ''};
  }

  String? fortunePath(int btnId) => fortuneImageMap[btnId];

  List<String> imagePaths() {
    List<String> imagePathList = [];
    imagePathList.add(fortuneImageMap[1]!);
    imagePathList.add(fortuneImageMap[2]!);
    imagePathList.add(fortuneImageMap[3]!);
    return imagePathList;
  }

  void setNewUser(UserPhoneInfo user) {
    if (this.userList == null) {
      this.userList = [];
    }
    this.userList.add(user);
  }

  void setFortune(Fortune fortune) {
    if (this.fortuneList == null) {
      this.fortuneList = [];
    }
    this.fortuneList.add(fortune);
  }

  String getUserPhoneId() {
    return this.userList[0].phoneId;
  }

  List getWidgets() {
    return this.widgets;
  }


  List<Fortune> getFortuneList() => this.fortuneList ==null ? [] : this.fortuneList;

  UserPhoneInfo getUser(UserPhoneInfo userId) {
    for (var user in userList) {
      if (user.phoneId == userId) {
        return user;
      }
    }
    return UserPhoneInfo(id: "0", name: "name", phoneId: "phoneId", location: "location", distance: "distance", description: "description", image: "image");
  }
}
