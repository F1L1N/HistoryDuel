import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:history_duel/UI/main.dart';
import 'package:history_duel/model/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:history_duel/model/post/registration.dart';
import 'package:history_duel/model/tokens.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  RegistrationScreenState createState() => new RegistrationScreenState();
}

// ignore: must_be_immutable
class RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  String repeatPassword;
  String login;
  Future<RegistrationPost> post;
  static final url = "http://hisduel.000webhostapp.com/registration.php";
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  TextEditingController loginController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Login"),
                      controller: loginController,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: sizeTextBlack,
                      onSaved: (val) => login = val,
                      validator: (val) => val.length < 3 ? 'Login too short.' : null,
                    ),
                    width: 300.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Email"),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: sizeTextBlack,
                      onSaved: (val) => email = val,
                      validator: (val) => !val.contains("@") ? 'Not a valid email.' : null,
                    ),
                    width: 300.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Password"),
                      controller: passwordController,
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) => val.length < 6 ? 'Password too short.' : null,
                      onSaved: (val) => password = val,
                      style: sizeTextBlack,
                    ),
                    width: 300.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Repeat password"),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) => password != repeatPassword ? 'Passwords not the same.' : null,
                      onSaved: (val) => password = val,
                      style: sizeTextBlack,
                    ),
                    width: 300.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: postRequest,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Registration",
                        style: sizeTextWhite,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void navigateMain(){
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new MainScreen(new Profile())));
  }

  Future<Tokens> createPost({Map body}) async {
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: body
    );
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Tokens.fromJson(json.decode(response.body));
  }

  void postRequest() async {
    RegistrationPost newPost = new RegistrationPost(
        login: loginController.text, email: emailController.text, password: passwordController.text);
    Tokens tokens = await createPost(body: newPost.toMap());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access", tokens.accessToken);
    prefs.setString("refresh", tokens.refreshToken);
    navigateMain();
  }
}