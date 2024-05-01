import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Color blueBackgroundColor = _colorFromHex("#42b9dd");
Color greenBackgroundColor = _colorFromHex("#74c44c");
Color bckgroundColor_pink = _colorFromHex("#c86dd7");
Color bckgroundColor_blue = _colorFromHex("#6433be");
const Color cardBlue = Color(0xFF333366);

const Color loginIconsColor = Colors.white;
const Color white = Colors.white;
const Color cyan = Colors.cyan;
const Color red = Colors.red;
const Color redAccent = Colors.redAccent;
const Color pink = Colors.pink;
Color? lightpink = Colors.pink[300];
Color? startpink = Colors.pink[400];
Color? darkpink = Colors.pink[800];
const Color deepOrange = Colors.deepOrange;
const Color green = Colors.green;
Color? darkBlue = Colors.blue[900];
const Color grey = Colors.grey;
Color gradient = <Color>[grey,pink] as Color ;

TextStyle textStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: white,fontFamily: 'YatraOne', );
TextStyle redTextStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: red,fontFamily: 'YatraOne',);
TextStyle blackTextStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black,fontFamily: 'YatraOne',);
TextStyle whiteButtonTextStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue,fontFamily: 'YatraOne',);
TextStyle formButtonTextStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue,fontFamily: 'YatraOne',);

TextStyle whiteTextFormStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: white,fontFamily: 'YatraOne',);
TextStyle blueTextFormStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue,fontFamily: 'YatraOne',);

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class AppTheme{
  static const primaryColor= Color(0xFF00512D);
  static const secondaryColor= Color(0xFFCF9F69);
  static const whiteColor= Color(0xFFFCFCFC);
  static const darkColor= Color(0xFF382E1E);
}