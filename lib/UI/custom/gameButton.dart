import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {

  int answer;
  String variant;
  VoidCallback buttonPressed;

  GameButton(int variantIndex, String buttonText, VoidCallback buttonPressed) {
    answer = variantIndex;
    variant = buttonText;
    this.buttonPressed = buttonPressed;
  }

  GameButtonState createState() => GameButtonState();
}

class GameButtonState extends State<GameButton> {
  Color buttonColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      onPressed: sendAnswer,
      child: new Text(widget.variant),
      minWidth: 300,
      color: buttonColor,

    );
  }

  void sendAnswer()
  {
    widget.buttonPressed();
    setState(() {
      buttonColor = Colors.amberAccent;
    });
  }
}