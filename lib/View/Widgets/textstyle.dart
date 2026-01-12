import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
 final FontWeight? fontWeight;

  const CustomTextStyle({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.fontSize = 13.0,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
