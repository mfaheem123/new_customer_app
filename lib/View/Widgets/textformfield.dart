import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? lable;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxlength;
  final double FontSize;
  final EdgeInsetsGeometry contentPadding;
  final Color fillColor;
  final double borderRadius;
  final bool enabled;
  final dynamic inputFormatters;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.lable,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.maxlength,
    this.FontSize = 12,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),
    // this.fillColor = const Color(0xFF324DA1),
    //this.fillColor = const Color(0xFF324DA1),
    this.fillColor = Colors.white70,
    this.borderRadius = 5,
    this.enabled = true,
    this.inputFormatters,
    this.focusNode,

  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      //borderSide: BorderSide(color: Color(0xFF4F46E5)),
        //borderSide: BorderSide(color: Colors.blueGrey),
      borderSide: BorderSide(color: Colors.blueGrey),
    );

    return TextFormField(
      maxLength: maxlength,
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      inputFormatters: [],
      style: AppTextStyles.regular(color: Colors.black),

      decoration: InputDecoration(
        label: lable,
        hintText: hintText,
        //hintStyle: TextStyle(color: Colors.white, fontSize: FontSize),
        hintStyle: AppTextStyles.regular(color: Colors.blueGrey, size: FontSize),
        // labelStyle:  TextStyle(color: CustomColor.Text_Color),
        filled: true,
        fillColor: fillColor,
        //fillColor:Colors.transparent,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
         // borderSide: const BorderSide(color: Colors.white, width: 1.2),
            borderSide: const BorderSide(
              //color: Color(0xFF4F46E5),
              color: Colors.white,

                //color: Color(0xFF4F46E5),
                width: 2),

        ),
        disabledBorder: border,
      ),
    );
  }
}
