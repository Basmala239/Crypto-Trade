import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/model/option_item_model.dart';

Widget optionWidget(OptionItemModel item){
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: MyColor.secondaryColor,
      borderRadius: BorderRadius.circular(16),
    ),
      child: Row(
    children: [
      Stack(
        children: [
          SvgPicture.asset(AssetsManager.iconBackground),
          SvgPicture.asset(item.image),
        ],
      ),
      SizedBox(width: 8,),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: MyColor.mainColor,
          ),),
          Text(item.subTitle, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: MyColor.grayB7,
          ),
          ),
        ],
      ),
      Spacer(),
      IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward,color: MyColor.gray77, ))
    ],
  )
  );

}