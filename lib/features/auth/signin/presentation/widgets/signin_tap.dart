import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/cupertino.dart';

Widget customTap({required String text, required bool isActive, required VoidCallback onClick,double width =180, var color = MyColor.backgroundColor}) {
  return GestureDetector(
    onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? color : MyColor.secondaryColor,
        ),
        child: Text(text, style: TextStyle(
          color: isActive ? (color==MyColor.mainColor ? MyColor.secondaryColor: MyColor.grayCD ): MyColor.gray77,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),),
      ));
}