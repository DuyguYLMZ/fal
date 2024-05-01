import 'package:example/values/lang/strings.dart';
import 'package:flutter/material.dart';

enum TabItem { home, newFortune, profile }

const Map<TabItem, String> tabName = {
  TabItem.home:      Values.HOME,
  TabItem.newFortune:     Values.NEW,
  TabItem.profile:      Values.PROFILE,
  //TabItem.settings:       Values.SETTINGS,
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home:       Colors.red,
  TabItem.newFortune: Colors.blue,
  TabItem.profile:    Colors.green,
 // TabItem.settings:   Colors.teal,
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.home:      Icons.home,
  TabItem.newFortune: Icons.add,
  TabItem.profile:  Icons.person,
 // TabItem.settings: Icons.settings,
};