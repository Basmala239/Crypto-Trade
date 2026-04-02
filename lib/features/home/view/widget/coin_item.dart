import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/data/model/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets_manager.dart';
import '../../../../data/model/responce/coin.dart';
import '../../../../data/model/responce/coin_market.dart';

Widget coinItemWidget(Coin item) {
  return Container(
    width: 170,
    padding: EdgeInsets.all(12),
    height: 110,
    decoration: BoxDecoration(
      color: MyColor.secondaryColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.formattedPrice,
              style: TextStyle(
                  color: MyColor.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),),
            ClipOval(
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.network(
                  item.imageUrl),
              )
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(item.name,
              style: TextStyle(
                  color: MyColor.gray77,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(width: 2,),
            Text(item.formattedChange,
              style: TextStyle(
                  color: item.isPriceUp ?MyColor.mainColor: MyColor.pink4B,
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),)
          ],
        ),
        SizedBox(height: 32,),
        SvgPicture.asset(
            item.isPriceUp ? AssetsManager.goodTrend : AssetsManager.badTrend)
      ],
    ),
  );
}