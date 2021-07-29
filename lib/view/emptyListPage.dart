import 'package:example/values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
     /*   decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.grey, Colors.grey],
          ),
        ),*/
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: new EdgeInsets.symmetric(vertical: 5.0),
      alignment: FractionalOffset.centerLeft,
      child: Text("Boooş")
    );

  }
}