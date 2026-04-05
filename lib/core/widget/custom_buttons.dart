import 'package:flutter/material.dart';
import '../colors.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap, this.editWidth=180, this.color = MyColor.mainColor });
  final String text;
  final VoidCallback onTap;
  final double editWidth;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width:editWidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: MyColor.buttonTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}