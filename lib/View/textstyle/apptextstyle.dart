import 'package:customer/View/Widgets/color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {

  //  Heading
  static TextStyle heading({double? size, Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: size ?? 24,
      fontWeight: weight ?? FontWeight.w600,
      color: color ?? CustomColor.Text_Color,
        decoration:TextDecoration.none
    );
  }

  //  Medium
  static TextStyle medium({double? size, Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.w500,
      color: color ?? CustomColor.Text_Color,
      decoration:TextDecoration.none
    );
  }

  //  Regular
  static TextStyle regular({double? size, Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: size ?? 15,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? CustomColor.Text_Color,
        decoration:TextDecoration.none
    );
  }

  //  Small
  static TextStyle small({double? size, Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: size ?? 12,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? CustomColor.Text_Color,
        decoration:TextDecoration.none
    );
  }

}


































// import 'package:customer/View/Widgets/color.dart';
// import 'package:flutter/material.dart';
//
// class AppTextStyles {
//
//   static TextStyle heading({double? size, Color? color, FontWeight? weight}) {
//     return TextStyle(
//       fontFamily: "Poppins",
//       fontSize: size ?? 24,
//       fontWeight: weight ?? FontWeight.w600,
//       color: CustomColor.Text_Color,
//     );
//   }
//
//
//   static TextStyle medium({double? size, Color? color, FontWeight? weight}) {
//     return TextStyle(
//       fontFamily: "Poppins",
//       fontSize: size ?? 18,
//       fontWeight: weight ?? FontWeight.w500,
//       color: CustomColor.Text_Color,
//     );
//   }
//
//
//   static TextStyle regular({double? size, Color? color, FontWeight? weight}) {
//     return TextStyle(
//       fontFamily: "Poppins",
//       fontSize: size ?? 14,
//       fontWeight: weight ?? FontWeight.w400,
//       color: CustomColor.Text_Color,
//     );
//   }
//
//
//   static TextStyle small({double? size, Color? color, FontWeight? weight}) {
//     return TextStyle(
//       fontFamily: "Poppins",
//       fontSize: size ?? 12,
//       fontWeight: weight ?? FontWeight.w400,
//       color: color,
//     );
//   }
// }
//
