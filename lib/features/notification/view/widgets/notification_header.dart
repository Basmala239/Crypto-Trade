import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';

Widget notificationHeader(VoidCallback onClick, BuildContext context) {
  return Row(
    children: [
      IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back, color: MyColor.grayCD,)
      ),
      Text("Notifications", style: TextStyle(
          color: MyColor.white, fontSize: 18, fontWeight: FontWeight.w700),),
      Spacer(),
      TextButton(onPressed: onClick,
          child: Row(
              children: [
                Text("Mark Read All", style: TextStyle(
                    color: MyColor.gray77, fontSize: 14, fontWeight: FontWeight.w400),),
                SizedBox(width: 4,),
                Icon(Icons.filter_alt_outlined, color: MyColor.grayCD,)
              ]
          ),
      )
    ],
  );
}