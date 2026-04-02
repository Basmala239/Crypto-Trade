import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget walletAppBar() {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Text("Current Balance", style: TextStyle(color: MyColor.gray77,
              fontSize: 14,
              fontWeight: FontWeight.w400),),
          SizedBox(height: 12,),
          Text("40,059.83", style: TextStyle(color: MyColor.white,
              fontSize: 32,
              fontWeight: FontWeight.w700),),
          SizedBox(height: 4,),
          Text("\$468,554.23", style: TextStyle(color: MyColor.grayB7,
              fontSize: 14,
              fontWeight: FontWeight.w400),),
          SizedBox(height: 20,),
        ],
      ),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off, color: MyColor.gray77,))
    ],
  );
}