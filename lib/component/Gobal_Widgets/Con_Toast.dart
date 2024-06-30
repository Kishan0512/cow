import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 1)}) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    // Create a new OverlayEntry
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 -
            50, // Adjust vertical position as needed
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              softWrap: true,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
