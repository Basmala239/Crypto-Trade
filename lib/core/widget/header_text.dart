import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';

Widget headerText(String text) {
  return Column(
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: MyColor.white,
        ),
      ),
    ],
  );
}