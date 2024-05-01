import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/theme.dart';
import '../view/pages/fortuneDetail.dart';

class FortuneItem extends StatefulWidget {
  bool isSelected;
  bool isTouchable = true;
  final String? title;
  final String? date;
  final String? fortune;

  FortuneItem(
      {Key? key,
      required this.isSelected,
      required this.isTouchable,
      required this.title,
      required this.fortune,
      required this.date})
      : super(key: key);

  @override
  State<FortuneItem> createState() => _FortuneItemState();
}

class _FortuneItemState extends State<FortuneItem> {
  late Map<String, dynamic> fortuneData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.fortune != null && widget.fortune != "null" && widget.fortune.toString() != ""){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new FortuneDetailScreen(fortune: widget.fortune, date: widget.date, title: widget.title),
          ));
        }

      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: cardBlue,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/pink_logo.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width:10),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: Text(
                               widget.date.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTouch() {
    setState(() {
      //widget.isSelected = !widget.isSelected;
    });
  }


}
