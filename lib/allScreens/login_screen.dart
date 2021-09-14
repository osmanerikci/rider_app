// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rider_app/allScreens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";

  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/images/bike.png"),
                width: 150,
                height: 150,
              ),
              //    SizedBox(height: 15),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Brand Bold",
                    fontWeight: FontWeight.bold),
              ),
              buildEmailField(),
              buildPasswordField(),
              SizedBox(
                height: 5,
              ),
              LoginButton(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have an Account? Register Here",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildEmailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  TextField buildPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("Login button pressed.");
        },
        child: Text(
          "Login with Email",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.blue)))));
  }
}
