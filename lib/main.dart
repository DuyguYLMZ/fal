
import 'package:example/view/pages/home.dart';
import 'package:example/view/pages/logincard.dart';
import 'package:example/view/pages/signupcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null ? LoginPage.id : Home.id,

      routes: {
        LoginPage.id: (context) => LoginPage(),
        SignupPage.id: (context) => SignupPage(),
        Home.id: (context) => Home(),
      },
      home: Home(),
    );
  }

}
