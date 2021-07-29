import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingsTabState();
  }
}

class SettingsTabState extends State<SettingsTabWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(backgroundColor: Colors.yellow,),
    );
  }
  _buildBody() {return Column();}
  @override
  bool get wantKeepAlive => true;
}
