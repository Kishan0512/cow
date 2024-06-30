import 'package:flutter/material.dart';

import 'Con_Icons.dart';
import 'Con_Widget.dart';

class Dialogs {
  static languageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(0.0),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 12.5,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff566a85),
                            Color(0xff72b4e5),
                            Color(0xff82bbda)
                          ],
                        ),
                      ),
                      child: const Text("Select Language"),
                    ),
                    Positioned(
                      top: -3,
                      right: -3,
                      child: Con_Wid.mIconButton(
                          onPressed: () {}, icon: Own_highlight_remove),
                    ),
                  ],
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0XFFE9F0F9),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return radioButton("English", 1);
                      },
                    )
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  static radioButton(String text, int value) {
    return RadioListTile(
      title: Text(text),
      value: false,
      groupValue: value,
      activeColor: const Color(0XFF4D719C),
      onChanged: (value) {},
    );
  }
}
