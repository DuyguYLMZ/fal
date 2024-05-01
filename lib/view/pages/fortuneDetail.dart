import 'package:example/values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FortuneDetailScreen extends StatefulWidget {
  final String? title;
  final String? date;
  final String? fortune;

  const FortuneDetailScreen(
      {required this.title, required this.date, required this.fortune});

  @override
  State<FortuneDetailScreen> createState() => _FortuneDetailScreenState();
}

class _FortuneDetailScreenState extends State<FortuneDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cardBlue, //Color(0xffA7D397),
        appBar: AppBar(
          backgroundColor: bckgroundColor_blue,
          centerTitle: true,
          title: Text(
            widget.title!,
            style: TextStyle(color: Colors.white),
          ),
          elevation: 5,
        ),
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: Text(
                        widget.fortune!,
                        style: TextStyle(color: Colors.white),
                      )),
            )));
  }
}
