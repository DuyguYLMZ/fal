import 'package:flutter/cupertino.dart';

class ActiveUser extends ChangeNotifier {
  String? name;
  String? email;
  String? birthday;

  ActiveUser();
  /*ActiveUser({
    required this.username,
    required this.email,
    required this.birthday,
    required this.coffeecount,
    required this.freecoffee,
  });*/

  void onChange() {
    notifyListeners();
  }
}
