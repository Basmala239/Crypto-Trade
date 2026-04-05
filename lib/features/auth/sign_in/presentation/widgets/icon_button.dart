import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.text, required this.onTap,required this.icon });
  final String text;
  final VoidCallback onTap;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width:180,
        decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 10,),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: MyColor.buttonTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}