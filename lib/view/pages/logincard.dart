
import 'package:example/view/pages/signupcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/AuthService.dart';
import '../../values/theme.dart';
import 'home.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'login';
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
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
                children: [
                  _header(context),
                  _inputField(_emailController,_passwordController,context),
                  _forgotPassword(context),
                  _signup(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    Size size = MediaQuery.of(context).size;
    return  Image.asset(
      'assets/images/pink_logo.png',
      width: size.width / 2,
    );
  }

  _inputField(_emailController,_passwordController, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "E-mail Adresi",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(38),
                  borderSide: BorderSide.none),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () async {
            final message = await AuthService().login(
              email: _emailController.text,
              password: _passwordController.text,
            );
            if (message!.contains('Giriş')) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            }

          },
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: lightpink,
                borderRadius: BorderRadius.circular(30)),
            child: const Text('Giriş',
                style: TextStyle(
                    color: AppTheme.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Şifrenizi mi unuttunuz mu?",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  _signup(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Hesabınız yok mu? ", style: TextStyle(color: Colors.white70),),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupPage()));
            },
            child: const Text(
              "Kayıt ol",
              style: TextStyle(color: Colors.pink),
            ))
      ],
    );
  }
}
