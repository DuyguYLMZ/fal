
import 'package:example/view/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

alertSuccessDialog(BuildContext _context) {
  return showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Done'),
          content: Text('Add Success'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        );
      });
}



showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoading(BuildContext context) async {
  await Future.delayed(Duration(microseconds: 1));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bekleeeee"),
          content: Text("HAHAHA"),
        );
      });
}

 alertMissingImageDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eksik Görüntü'),
          content: Text('Lütfen 3 görüntü ekleyin '),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

alertMissingFieldDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eksik bilgi'),
          content: Text('Lütfen bilgilerinizi kontrol edin, boş alan kalmadığından emin olun.'),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
