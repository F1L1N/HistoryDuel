import 'dart:async';
import 'package:flutter/material.dart';

class GameTimer extends StatefulWidget {
  @override
  VoidCallback _onTap;
  TimerState createState() => TimerState();

  GameTimer(this._onTap);
}

class TimerState extends State<GameTimer> {

  Timer _timer;

  int _start = 30;

  TimerState() {
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            this.widget._onTap();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Text("$_start");
  }
}
