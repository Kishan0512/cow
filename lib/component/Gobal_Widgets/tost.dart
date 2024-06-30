import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herdmannew/UiScreens/DrawerScreens/VisitRegistration/VisitRegistration.dart';
import 'package:herdmannew/component/Gobal_Widgets/Con_Widget.dart';

import '../../UiScreens/Splesh/SplashScreen.dart';

class Toast {
  static void show(BuildContext context, String message) {
    final theme = Theme.of(context);
    final text = Material(
      color: Colors.transparent,
      child: Con_Wid.gText(
        message,
        style: TextStyle(
            background: Paint()
              ..color = Colors.black
              ..strokeJoin = StrokeJoin.round
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke
              ..strokeWidth = 25.0,
            color: Colors.white,
            fontSize: 12.0),
      ),
    );

    final container = Container(
      height: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(bottom: 50, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black38,
      ),
      child: text,
    );
    final positioned = Positioned.fill(
      bottom: 50,
      child: Align(
        alignment: MediaQuery.of(context).viewInsets.bottom == 0
            ? Alignment.bottomCenter
            : Alignment.center,
        child: text,
      ),
    );

    final overlayEntry = OverlayEntry(
        builder: (context) => Stack(
            alignment: Alignment.bottomCenter,
            children: [Container(child: positioned)]));
    Overlay.of(context).insert(overlayEntry);

    Timer(Duration(milliseconds: 2500), () {
      overlayEntry.remove();
    });
  }

  static int calculateC(int width, int length) {
    return (width / length).round();
  }
}


