import 'package:flutter/material.dart';

import 'Con_Color.dart';

class ConStyle {
  static style_white_14s_100w() {
    return const TextStyle(
      color: Conclrfontmain,
      overflow: TextOverflow.ellipsis,
      fontSize: 11,
      // fontFamily: 'Gardenia'
    );
  }

  static style_white_14s_500w() {
    return const TextStyle(
      color: fontwhiteColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static style_Blk_11s() {
    return const TextStyle(fontSize: 14, fontFamily: "Poppins",color: Colors.white);
  }

  static style_Blk_14s({Color? pColor}) {
    return TextStyle(
        color: pColor ?? Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins");
  }

  static style_white_18s_500w() {
    return const TextStyle(
      color: fontwhiteColor,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
  }

  static style_theme_14s_600w() {
    return const TextStyle(
      color: Conclrfontmain,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    );
  }

  static style_theme_16s_500w() {
    return TextStyle(
      color: con_clr.ConClr2 ? ConClrBtntxt : whiteColor,
      fontSize: 13,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w500,
    );
  }

  static style_theme_16s_600w() {
    return const TextStyle(
      color: ConClrBtntxt,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }

  static style_white_12s_600w() {
    return const TextStyle(
      color: fontBlackColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }

  static style_white_18s_600w() {
    return const TextStyle(
      color: fontBlackColor,
      fontSize: 18,
    );
  }

  static Style_white_16s_700w() {
    return TextStyle(
        color: fontwhiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Gardenia');
  }

  static Style_white_8s_500w(Color pcolor) {
    return TextStyle(
      color: pcolor,
      fontSize: 10,
      fontWeight: FontWeight.w100,
      fontFamily: 'Poppins',
    );
  }

  static Style_white_10s_500w(Color pcolor) {
    return TextStyle(
      color: pcolor,
      fontSize: 10,
      fontWeight: FontWeight.w100,
      fontFamily: 'Poppins',
    );
  }

  static Style_white_13s_700w(Color pcolor) {
    return TextStyle(
      color: pcolor,
      fontSize: 15,
      fontWeight: FontWeight.w200,
      fontFamily: 'Poppins',
    );
  }

  static Style_white_14s_700w(Color pcolor) {
    return TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: 'Poppins',
      color: pcolor,
      fontSize: 13,
      fontWeight: FontWeight.w200,
    );
  }

  static Style_white_14_700w(Color pcolor) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: pcolor,
      fontSize: 13,
      fontWeight: FontWeight.w200,
    );
  }

  static Style_white_12_700w(Color pcolor) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: pcolor,
      fontSize: 10,
      fontWeight: FontWeight.w200,
    );
  }
}
