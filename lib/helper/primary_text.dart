import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const PrimaryText({
    Key? key,
    required this.text,
    this.fontSize = 22,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}

