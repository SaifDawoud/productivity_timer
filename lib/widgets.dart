import 'dart:ui';

import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;
  ProductivityButton(
      {@required this.color,
      @required this.onPressed,
      @required this.size,
      @required this.text});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      color: this.color,
      child: Text(
        this.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      minWidth: this.size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String settings;
  final CallbackSetting callback;
  final double size;
  SettingsButton(this.color, this.text, this.size, this.value, this.settings,
      this.callback);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: (() {
        this.callback(this.settings, this.value);
      }),
      color: this.color,
      minWidth: this.size,
    );
  }
}
