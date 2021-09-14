// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/allScreens/login_screen.dart';
import 'package:rider_app/main.dart';

class RegistrationScreen extends StatefulWidget {
  static const String idScreen = "register";

  RegistrationScreen({Key key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50),
              Image(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/images/logo.png"),
                width: 150,
                height: 150,
              ),
              //    SizedBox(height: 15),
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Brand Bold",
                    fontWeight: FontWeight.bold),
              ),
              buildName(),
              buildEmailField(),
              buildPhone(),
              buildPasswordField(),
              SizedBox(
                height: 5,
              ),
              buildTextButton(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.idScreen,
                    (route) => false,
                  );
                },
                child: Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildTextButton() {
    return TextButton(
      onPressed: () {
        if (nameTextEditingController.text.length < 3) {
          buildtoastMessage("Name must be at least 3 characters.", context);
        } else if (!emailTextEditingController.text.contains("@")) {
          buildtoastMessage("Please enter a valid email address.", context);
        } else if (emailTextEditingController.text.isEmpty) {
          buildtoastMessage("Phone number can't be empty.", context);
        } else if (passwordTextEditingController.text.length < 4) {
          buildtoastMessage("Password must be at least 4 characters.", context);
        } else {
          registerNewUser(context);
        }
      },
      child: Text(
        "Registration with Email",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

//context hangi sayfada olduğunu anlaması için lazım
  void buildtoastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  TextField buildName() {
    return TextField(
      controller: nameTextEditingController,
      decoration: InputDecoration(
        labelText: "Name",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  TextField buildEmailField() {
    return TextField(
      controller: emailTextEditingController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  TextField buildPhone() {
    return TextField(
      controller: phoneTextEditingController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: passwordTextEditingController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      buildtoastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      //okay
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      usersRef.child(firebaseUser.uid).set(userDataMap);
      buildtoastMessage(
          emailTextEditingController.text.trim() +
              "Congratulations, your account has been created.",
          context);

      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.idScreen, (route) => false);
    } else {
      buildtoastMessage("New user account NOT been created.", context);
    }
  }
}
