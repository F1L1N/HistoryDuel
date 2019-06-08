import 'package:flutter/material.dart';

class gameButton extends StatelessWidget {

  int answer;
  String variant;

  gameButton(int variantIndex, String buttonText)
  {
    answer = variantIndex;
    variant = buttonText;
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: sendAnswer,
      child: new Text('$variant'),
    );
  }

  void sendAnswer()
  {

  }
}