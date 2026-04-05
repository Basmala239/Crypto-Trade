import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.onTap,
    this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onToggleVisibility,
    this.initialValue,
  });

  final String hint;
  final bool isPassword;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleVisibility;
  final String? initialValue;
  bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      decoration: BoxDecoration(
        color: MyColor.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 50,
        width: 360,
        child: TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: MyColor.gray77,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
            border: InputBorder.none,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                widget.obscureText ? Icons.visibility : Icons.visibility_off,
                color: MyColor.gray77,
              ),
              onPressed: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
                widget.onToggleVisibility?.call();
              },
            )
                : null,
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}