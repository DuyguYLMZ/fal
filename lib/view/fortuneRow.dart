import 'package:example/model/fortune.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/pages/fortuneview.dart';
import 'package:flutter/material.dart';

class PlanetRow extends StatelessWidget {
  final Fortune fortune;

  PlanetRow(this.fortune);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 5.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(fortune.image),
        height: 100.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    Widget _planetValue({String value, String image}) {
      return new Row(children: <Widget>[
       new Image.asset(image, height: 12.0),
        new Container(width: 8.0),
        new Text(fortune.gravity, style: regularTextStyle),
      ]);
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: Row(
        children: [
          Row(
            children: [
              planetThumbnail,
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(height: 4.0),
                  new Text(fortune.name, style: headerTextStyle),
                  new Container(height: 10.0),
                  new Text(fortune.location, style: subHeaderTextStyle),
                  new Container(
                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.0,
                      width: 18.0,
                      color: new Color(0xff00c6ff)),
                 /* new Row(
                    children: <Widget>[
                      new Expanded(
                          child: _planetValue(
                              value: fortune.distance,
                              image: 'assets/images/pink_logo.png'
                    )),
                      new Expanded(
                          child: _planetValue(
                              value: fortune.gravity,
                              image: 'assets/images/pink_logo.png'
                            ))
                    ],
                  ),*/
                ],
              ),
            ],
          ),
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: 124.0,
     // margin: new EdgeInsets.only(left: 16.0),
      decoration: new BoxDecoration(
        color: cardBlue,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: new Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 4.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
            ],
          )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FortuneViewPage()),
        );
          print('row');
      },
    );
  }
}
