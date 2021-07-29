import 'package:example/controller/FortunePathProvider.dart';
import 'package:example/model/fortune.dart';
import 'package:example/model/user.dart';
import 'package:example/util/deviceInfo.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/emptyListPage.dart';
import 'package:example/view/fortuneRow.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FortuneListPage extends StatefulWidget {
  FortuneListPage({Key key}) : super(key: key);

  @override
  _FortuneListPageState createState() => _FortuneListPageState();
}

class _FortuneListPageState extends State<FortuneListPage> {
  var dbRef;
  var _provider;
  Future<List<String>> _deviceList;

  @override
  void initState() {
    super.initState();
  }

  void setFortuneList() {
    this.dbRef = FirebaseDatabase.instance
        .reference()
        .child(_provider.getUserPhoneId().toString());
  }

  setTokenId() async {
    _deviceList = DeviceInfo.getDeviceDetails();
    var list = await _deviceList;
    /*  _deviceList = Stream<List<String>>.fromIterable(
      <List<String>>[list],
    );*/
    //  _deviceList = await DeviceInfo.getDeviceDetails();
    User user = User(
      id: "2",
      name: "Neptune",
      location: "Milkyway Galaxy",
      distance: "54.6m Km",
      phoneId: list[2].toString(),
      description: "Lorem ipsum...",
      image: "assets/images/pink_logo.png",
    );
    _provider.setNewUser(user);
  }

  @override
  Widget build(BuildContext context) {
    this._provider = Provider.of<FortunePathProvider>(context, listen: false);
    setTokenId();
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: cardBlue,
          title: Text(
            "Fallarım",
          ),
        ),
        body: FutureBuilder(
            future: _deviceList,
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: cardBlue,
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                setFortuneList();
              }
              return FutureBuilder(
                  future: dbRef.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.value != null) {
                        Map<dynamic, dynamic> values = snapshot.data.value;
                        values.forEach((key, values) {
                          Fortune fortune = Fortune(
                            id: "1",
                            name: "Mars",
                            location: values,
                            distance: "54.6m Km",
                            gravity: "3.711 m/s ",
                            description: values,
                            image: "assets/images/purple_logo.png",
                          );
                          if (!(_provider.getFortuneList().any((e) =>
                              e.location == values &&
                              e.description == values))) {
                            _provider.setFortune(fortune);
                            _provider.getWidgets().add(PlanetRow(fortune));
                          }
                        });
                        return ListView.builder(
                            itemCount: _provider.getWidgets().length,
                            itemBuilder: (BuildContext context, int position) {
                              return PlanetRow(
                                  _provider.getFortuneList()[position]);
                            });
                      } else {
                        return EmptyPage();
                      }
                    }
                    return Center(child: CircularProgressIndicator(  backgroundColor: cardBlue,));
                  });
            }));
  }
}
