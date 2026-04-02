import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget emptyView(String image, String title, String subTitle){
  return Center(
    child: Column(
      children: [
        SvgPicture.asset(image),
        SizedBox(height: 8,),
        Text(title,
        style: TextStyle(
          color: MyColor.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),),
        SizedBox(height: 8,),
        Text(subTitle,
          style: TextStyle(
            color: MyColor.gray77,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          ),
      ],
    ),
  );
}