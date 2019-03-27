import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:history_duel/UI/main.dart';
import 'package:history_duel/UI/reg.dart';
import 'package:history_duel/model/post/authentification.dart';
import 'package:history_duel/model/profile.dart';
import 'package:history_duel/model/tokens.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => new AuthScreenState();
}

// ignore: must_be_immutable
class AuthScreenState extends State<AuthScreen> {
  String email;
  String password;
  bool isLoggedIn;
  var url = "";
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  TextEditingController loginController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
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
                      obscureText: true,
                      controller: passwordController,
                      maxLines: 1,
                      validator: (val) => val.length < 6 ? 'Password too short.' : null,
                      onSaved: (val) => password = val,
                      style: sizeTextBlack,
                    ),
                    width: 300.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Container(
                    child: new GestureDetector(
                      onTap: (){
                        navigateMain();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    padding: new EdgeInsets.only(top: 15.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submit,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "LOGIN",
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

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => auth(context));
  }

  Future<Profile> createProfilePost({Map body}) async {
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
    return Profile.fromJson(json.decode(response.body));
  }

  Future<Tokens> createAuthPost({Map body}) async {
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

  Future auth(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("access") != null)
    {
      url = "http://hisduel.000webhostapp.com/access.php";
    }
    else
    {
      if (prefs.get("refresh") != null)
      {
        url = "http://hisduel.000webhostapp.com/refresh.php";
      }
      else
      {
        url = "http://hisduel.000webhostapp.com/authentication.php";
        AuthenticationPost newPost = new AuthenticationPost(
            login: loginController.text, password: passwordController.text);
        Tokens tokens = await createAuthPost(body: newPost.toMap());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access", tokens.accessToken);
        prefs.setString("refresh", tokens.refreshToken);
      }
    }
    navigateMain();
  }

  void submit() {

  }

  void navigateMain(){
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new MainScreen()));
  }
}