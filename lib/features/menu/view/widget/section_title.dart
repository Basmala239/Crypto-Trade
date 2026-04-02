import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';

Widget sectionTitle(String title){
  return Text(title,style:
    TextStyle(
        color: MyColor.grayCD,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}