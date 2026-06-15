import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'color.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final Widget? textWidget;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  const MyElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textWidget,
    this.backgroundColor = CustomColor.Button_background_Color,
    this.textColor = CustomColor.Button_Text_Color,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: elevation,
        shadowColor: Colors.black.withOpacity(0.3), // ✨ better shadow
        surfaceTintColor: Colors.transparent, // ✨ clean material look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide( // ✨ border decoration add
            color: textColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        padding: padding,
      ),
      onPressed: onPressed,
      child: textWidget ?? Text(
        text,
        style: AppTextStyles.medium(
          size: fontSize,
        ),
      ),
    );
  }
}













// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
//
// import 'color.dart';
//
// class MyElevatedButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;
//   final double borderRadius;
//   final double elevation;
//   final EdgeInsetsGeometry padding;
//   final  double fontSize;
//
//   const MyElevatedButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor = CustomColor.Button_background_Color,
//     this.textColor = CustomColor.Button_Text_Color,
//     this.borderRadius = 12.0,
//     this.elevation = 2.0,
//     this.fontSize =  16,
//
//
//     this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: backgroundColor,
//         foregroundColor: textColor,
//         elevation: elevation,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         padding: padding,
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: AppTextStyles.medium(
//           size: 16,
//         ),
//       ),
//     );
//   }
// }
