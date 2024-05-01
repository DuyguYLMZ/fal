import 'package:example/view/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _FullScreenLoader();
      },
    );
  }

  void showAlertSucces(BuildContext alertContext) {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gönderildi'),
            content: Text('Fallınız gönderildi'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(_context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(alertContext).pop();
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

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child: Center(child: CircularProgressIndicator()));
  }
}
