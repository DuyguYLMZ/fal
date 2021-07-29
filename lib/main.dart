
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shortcuts/shortcuts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInstalled = false;
  String text = 'blabla';

  Map shortcuts;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

    Application app = await DeviceApps.getApp('com.spotify.music');

    isInstalled = await DeviceApps.isAppInstalled('com.spotify.music');
    shortcuts = await ShortcutsAPI.getShortcuts("com.spotify.music");
    if (!mounted) return;

    setState(() {
      if(isInstalled){
        text = "yüklü";
      }else{
        text = "değil";
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(onPressed: (){
                DeviceApps.openApp('com.spotify.music');
              })
            ],
          ),
        ),
      ),
    );
  }
}
