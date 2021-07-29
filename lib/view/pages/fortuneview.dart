import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/controller/FortunePathProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';



















class FortuneViewPage extends StatefulWidget {
  FortuneViewPage({Key key}) : super(key: key);

  @override
  _FortuneViewPageState createState() => _FortuneViewPageState();
}

extension contexsize on BuildContext {
  double dynamicheight(double val) => MediaQuery.of(this).size.height * val;

  double dynamicwidth(double val) => MediaQuery.of(this).size.width * val;
}

class _FortuneViewPageState extends State<FortuneViewPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestore = FirebaseFirestore.instance;
  List asset = [];
  VideoPlayerController controller;
//  var _provider;

  @override
  void initState() {
    super.initState();
    firestore.collection("Posts").get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (doc.data().toString().contains("video")) {
              Map<dynamic, dynamic> xx = doc.data();
              asset.add(xx["video"]);
            }
          })
        });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firestore
            .collection('Posts')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> postssnapshot) {
          if (postssnapshot.hasData) {
            if (postssnapshot.connectionState == ConnectionState.done) {
              return PageView.builder(
                  itemCount: postssnapshot.data.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    controller = VideoPlayerController.network(asset[index]);
                    controller.initialize().then((_) {
                      controller.play();
                    });
                    controller.setLooping(true);
                    var videopost = postssnapshot.data.docs[index];
                    return Stack(children: [
                      Center(
                        child: Container(
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child:  FittedBox(
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                child: Container(
                                    width: 100,
                                    height: 200,
                                    child: VideoPlayer(controller)))
                          ),
                        ),
                      ),
                       Container(
                          height: 100,
                          width: 100,
                          child: SafeArea(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: context.dynamicwidth(0.03),
                                      left: context.dynamicwidth(0.03),
                                      bottom: context.dynamicheight(0.02)),
                                  child: Column(children: <Widget>[
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                  'Takip',

                                              )),
                                          SizedBox(
                                              width:
                                              context.dynamicwidth(0.025)),
                                          Text(
                                              '|'
                                          ),
                                          SizedBox(
                                              width:
                                              context.dynamicwidth(0.025)),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                  'Ã–nerilen',

                                              )),
                                        ]),
                                    Flexible(
                                        child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 100,
                                                  width: context.dynamicwidth(
                                                      0.8),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(children: [
                                                          CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  'https://firebasestorage.googleapis.com/v0/b/tahminlecarrylexstudio.appspot.com/o/Profileimages%2Fimage.jpg?alt=media&token=5e8541a0-de42-45cb-992d-9e7f1e13d227',
                                                                  scale: context
                                                                      .dynamicwidth(
                                                                      0.1))),
                                                          SizedBox(
                                                              width: context
                                                                  .dynamicwidth(
                                                                  0.01)),
                                                          Text(
                                                              'Username' /* ,
                                                             style: methodtextstyle(
                                                                              FontWeight
                                                                                  .w700,
                                                                              16,
                                                                              Colors
                                                                                  .white)*/
                                                          ),
                                                          SizedBox(
                                                              width: context
                                                                  .dynamicwidth(
                                                                  0.01)),
                                                          Text(
                                                              'Â·'
                                                          ),
                                                          SizedBox(
                                                              width: context
                                                                  .dynamicwidth(
                                                                  0.01)),
                                                          Text(
                                                              'Status'
                                                          ),
                                                        ]),
                                                        SizedBox(
                                                            height: context
                                                                .dynamicheight(
                                                                0.01)),
                                                       /* Text(
                                                          videopost['text'],
                                                        ),*/
                                                        SizedBox(
                                                            height: context
                                                                .dynamicheight(
                                                                0.01)),
                                                        Text(
                                                          'Time',
                                                        )
                                                      ])),
                                              Expanded(
                                                  child: Container(
                                                      height: 100,
                                                      child: Column(children: [
                                                        Container(
                                                          height: context
                                                              .dynamicheight(
                                                              0.4),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                    children: [
                                                                      InkWell(
                                                                          onTap: () {},
                                                                          child: Column(
                                                                              children: [

                                                                                SizedBox(
                                                                                    height:
                                                                                    context
                                                                                        .dynamicheight(
                                                                                        0.01)),
                                                                                Text(
                                                                                  '17K',
                                                                                )
                                                                              ])),
                                                                      SizedBox(
                                                                          height: context
                                                                              .dynamicheight(
                                                                              0.02)),
                                                                      InkWell(
                                                                          onTap: () {},
                                                                          child: Column(
                                                                              children: [
                                                                                SizedBox(
                                                                                    height:
                                                                                    context
                                                                                        .dynamicheight(
                                                                                        0.01)),

                                                                              ])),
                                                                      SizedBox(
                                                                          height: context
                                                                              .dynamicheight(
                                                                              0.02)),
                                                                      InkWell(
                                                                        onTap: () {

                                                                        },

                                                                      )
                                                                    ])))
                                                      ])))
                                            ]))
                                  ])))),
                    ]);
                  });
            }
          }
          return SizedBox();
        });
  }
}
/*  final firestoreInstance = FirebaseFirestore.instance;
  final textcontroller = TextEditingController();
  var dbRef;
  var _provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._provider = Provider.of<FortunePathProvider>(context, listen: false);
    String text = "eee";
    // CollectionReference document = firestoreInstance.collection("time");
    CollectionReference document = firestoreInstance.collection('Raffles');

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: cardBlue,
          title: Text(
            "Demo",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder(
          stream: document
              .doc('88123423')
              .collection('Deposits')
              .doc('varOlmayanUser_teswwt')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<dynamic> raffleusersnapshot) {
            if (!raffleusersnapshot.hasData) {
              return Container(
                child: Center(
                  child:
                  CircularProgressIndicator(backgroundColor: Colors.pink),
                ),
              );
            } else {
              if (!raffleusersnapshot.data.exists) {
                document.doc('88123423').collection('Deposits').doc(
                    'varOlmayanUser_tewwst').set({
                  "tcoin": 0,
                });
              } else {
                return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Text("${raffleusersnapshot.data['tcoin']}"),

                );
              }
              return Container(
                child: Center(
                  child:
                  CircularProgressIndicator(backgroundColor: Colors.blue),
                ),
              );
            }
          },));
  }*/
