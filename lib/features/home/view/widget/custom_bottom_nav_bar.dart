import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../data/model/home_grid_item_model.dart';

Widget bottomNavBarItem(bool isActive, HomeGridItemModel item){
  return GestureDetector(
    onTap: item.onClick,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SvgPicture.asset(item.icon,
        color: isActive? MyColor.mainColor : MyColor.gray77,),
      SizedBox(height: 4,),
      Text(item.label,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: isActive? MyColor.white : MyColor.gray77
        ),)
    ],),
  );

}