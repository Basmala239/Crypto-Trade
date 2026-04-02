import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/model/setting_item_model.dart';

Widget settingItem(SettingItemModel item){
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: MyColor.secondaryColor,

        ),
        child: SvgPicture.asset(
            item.icon
        ),
      ),
      SizedBox(width: 5,),
      Text(item.label,
        style: TextStyle(
          color: MyColor.grayCD,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),),
      Spacer(),
      Text(item.value,
      style: TextStyle(
        color: MyColor.gray77,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),),
      SizedBox(width: 5,),
      Icon(Icons.arrow_forward, color: MyColor.gray77,),
    ],
  );
}