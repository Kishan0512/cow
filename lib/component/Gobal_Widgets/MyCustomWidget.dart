
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ButtonState.dart';

class MyCustomWidget extends StatefulWidget {
  Function Onchanged;
  String Title;
  Color color;
  ButtonState stateTextWithIcon;
  MyCustomWidget({required this.Onchanged, required this.Title, required this.color,required this.stateTextWithIcon});

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  ButtonState stateOnlyText = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return ProgressButton.icon(
        textStyle: TextStyle(fontSize: 16,color: Colors.white),
        iconedButtons: {
      ButtonState.idle: IconedButton(
          text: 'Save',

          color: widget.color==null?Colors.deepPurple.shade500:widget.color),
      ButtonState.loading:
      IconedButton(text: 'Loading', color: widget.color==null?Colors.deepPurple.shade500:widget.color),
      ButtonState.fail: IconedButton(
          text: 'Failed',
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: 'Success',
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: widget.Onchanged, state: widget.stateTextWithIcon);
  }

}