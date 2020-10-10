import 'package:flutter/material.dart';

class BoxDecorations {
  static const BoxDecoration bg_white = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: Color(0x80DCE7FA),
          offset: Offset(0.0, 2.0),
          blurRadius: 8.0,
          spreadRadius: 0.0),
    ],
  );
}
