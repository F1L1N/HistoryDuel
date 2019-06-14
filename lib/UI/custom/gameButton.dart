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
    return new MaterialButton(
      onPressed: sendAnswer,
      child: new Text('$variant'),
      minWidth: 300,
      color: Colors.grey[300],

    );
  }

  void sendAnswer()
  {

  }
}