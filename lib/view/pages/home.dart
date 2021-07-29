import 'dart:collection';

import 'package:example/util/BottomNavigation.dart';
import 'package:example/util/TabItem.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/pages/profile.dart';
import 'package:example/view/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fortunelist.dart';
import 'fortuneview.dart';
import 'newfotune.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var _currentTab = TabItem.home;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  final Key keyOne = PageStorageKey("IndexTabWidget");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      backgroundColor: Colors.transparent,
    );
  }

 Widget _buildBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 8),
                child: showPage(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: 4),
                  child: BottomNavigation(
                    currentTab: _currentTab,
                    onSelectTab: _selectTab,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [bckgroundColor_pink, bckgroundColor_blue],
            )));

  }

  Widget showPage() {
    if (_currentTab == TabItem.profile) {
      return ProfileTabWidget();
    } else if (_currentTab == TabItem.newFortune) {
      return NewFortuneTabWidget();
    }/* else if (_currentTab == TabItem.settings) {
      *//*  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsTabWidget()),
      );*//*
      return SettingsTabWidget();
    } */else {
      return  FortuneViewPage();
    }
  }
}
