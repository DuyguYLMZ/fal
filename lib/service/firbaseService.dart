import 'package:example/controller/FortunePathProvider.dart';
import 'package:example/model/fortune.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseService extends StatelessWidget {
  var dbRef;
  var _provider;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    throw UnimplementedError();
  }
/*  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<void> signOut() async {
    _snapshotService.setWasteLessLifeUserObject({});
    return _firebaseAuth.signOut();
  }*/
}
