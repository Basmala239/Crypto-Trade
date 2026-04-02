import 'package:flutter/material.dart';

import '../colors.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({super.key,
    required this.hint,
    required this.onTap,
    this.isPassword = false,
    this.obscureText = false,
    this.textInputType = TextInputType
        .text,
  });

  final String hint;
  final bool isPassword;
  final VoidCallback? onTap;
  bool obscureText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        decoration: BoxDecoration(
          color: MyColor.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 50,
          width: 360,
          child: TextField(
            keyboardType: textInputType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: MyColor.gray77,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),

              border: InputBorder.none,
              suffixIcon: isPassword ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: MyColor.gray77,),
                onPressed: onTap,) : null,
            ),
          ),
        ),
      );
  }
}