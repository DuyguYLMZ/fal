import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../service/AuthService.dart';
import '../../util/cupertino_date_textbox.dart';
import '../../values/theme.dart';
import 'home.dart';
import 'logincard.dart';

class SignupPage extends StatefulWidget {
  SignupPage();

  static String id = 'signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static String id = 'signup';
  DateTime _selectedDateTime = DateTime.now();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPassController = TextEditingController();
  final TextEditingController _dateControler = TextEditingController();
  String? _date;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: cardBlue,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 60.0),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Hesap oluşturun",
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            hintText: "Kullanıcı",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(38.0),
                                color: Colors.white,
                                border: Border.all(
                                  style: BorderStyle.none,
                                  strokeAlign: -1,
                                  width: 8.0,
                                  color: Colors.white,
                                )),
                            child: DateTextBox(
                                initialValue: _selectedDateTime,
                                onDateChange: onBirthdayChange,
                                hintText: DateFormat.yMd()
                                    .format(_selectedDateTime))),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Şifre",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(38),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _verifyPassController,
                        decoration: InputDecoration(
                          hintText: "Şifre Tekrar",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(38),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final message = await AuthService().registration(
                          email: _emailController.text,
                          password: _passwordController.text,
                          displayName: _usernameController.text,
                          birthday: _date.toString());
                      if (message!.contains('Success')) {
                        final user =
                            FirebaseFirestore.instance.collection("users");
                        final data = <String, dynamic>{
                          'name': _usernameController.text,
                          'email': _emailController.text,
                          'birthday': _date,
                        };
                        user.doc(_emailController.text).set(data);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lightpink,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text('Kayıt ol',
                          style: TextStyle(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _login(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Bir hesabınız mı var?"),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              "Giriş",
              style: TextStyle(color: Colors.purpleAccent),
            ))
      ],
    );
  }

  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }
}
