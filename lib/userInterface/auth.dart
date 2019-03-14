import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:history_duel/userInterface/main.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => new AuthScreenState();
}

// ignore: must_be_immutable
class AuthScreenState extends State<AuthScreen> {
  String email;
  String password;
  bool isLoggedIn;
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
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
                      decoration: new InputDecoration(labelText: "Email"),
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
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) => val.length < 6 ? 'Password too short.' : null,
                      onSaved: (val) => password = val,
                      style: sizeTextBlack,
                    ),
                    width: 300.0,
                    padding: new EdgeInsets.only(top: 10.0),
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

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(
        _context,
        new MaterialPageRoute(
          builder: (context) => new MainScreen(email, password)));
          //builder: (context) => new MyApp()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}