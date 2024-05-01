import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/values/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:example/model/user.dart';
import '../../controller/FortunePathProvider.dart';
import '../../model/user.dart';
import '../../util/fortune_card.dart';
import '../../util/deviceInfo.dart';

class FortuneViewPage extends StatefulWidget {
  FortuneViewPage();

  @override
  _FortuneViewPageState createState() => _FortuneViewPageState();
}

extension contexsize on BuildContext {
  double dynamicheight(double val) => MediaQuery.of(this).size.height * val;

  double dynamicwidth(double val) => MediaQuery.of(this).size.width * val;
}

class _FortuneViewPageState extends State<FortuneViewPage> {
  var firestore;
  List asset = [];
  late List<UserPhoneInfo> userList;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var docSnapshot;
  var fortune;
  var _listLength;
  var _fortuneText;
  var _title;
  var _date;
  List<Map<String, String>> jsonData = [];

  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget _emptyScreen() {
    Size size = MediaQuery.of(context).size;
    return  RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/purple_logo.png',
                  width: size.width / 2,
                ),
                Text(
                  "Falınız yok",
                  style: TextStyle(color: Colors.white70),
                ),
              ],),
        ),
      ),
    );
  }

  Future getData() async {
    fortune = FirebaseFirestore.instance.collection("fortune");
    docSnapshot = await fortune.doc(auth.currentUser!.email).get();
    jsonData = [];
    // Get data from docs and convert map to List
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('fortune')
        .doc(auth.currentUser!.email)
        .collection('1')
        .get();
    List val = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var v in val) {
      Map<String, dynamic> testMap = v as Map<String, dynamic>;
      for (var w in testMap.entries) {
        if("title" ==w.key.toString()){
            _title= w.value.toString();
        }
        else if("fortune" == w.key.toString()){
          _fortuneText = w.value.toString();
        }
        else if("date" == w.key.toString()){
          DateTime dateTime = DateTime.parse(w.value.toDate().toString());
          _date = (DateFormat('dd-MMM-yyy').format(dateTime));
        }

      }
      Map<String, String> mapWord = {
        "date": _date,
        "fortune": _fortuneText,
        "title": _title
      };
      jsonData.add(mapWord);
    }


    _listLength = querySnapshot.docs.length;

    if(_listLength != null && _listLength>0){
      setState(() => _body = _build());
    } else{
      setState(() => _body = _emptyScreen());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Widget _build() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "Fallar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: StreamBuilder(
              stream: fortune.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: _listLength,
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return FortuneItem(
                          date: jsonData[index]["date"],
                          title:  jsonData[index]["title"],
                          fortune:  jsonData[index]["fortune"],
                          isTouchable: true,
                          isSelected: false);
                    },
                  );
                }
              }),
        ));
  }

  Future<void> _pullRefresh() async {
    setState(() {
      getData();
    });
  }
}
