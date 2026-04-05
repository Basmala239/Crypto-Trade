import 'package:crypto_trade/core/string_extensions.dart';
import 'package:crypto_trade/data/model/response/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_manager.dart';
import '../../../core/colors.dart';

Widget marketItemWidget(Coin item,VoidCallback onClick) {
  return
  GestureDetector(
    onTap: onClick,
    child: Padding(padding: EdgeInsetsGeometry.all(8),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.network(item.imageUrl),
            )

          ),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name.firstTwoWords, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text(item.symbol, style: TextStyle(
                  color: MyColor.gray77,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),
          Spacer(),
          SvgPicture.asset(
              item.isPriceUp ? AssetsManager.goodTrend : AssetsManager.badTrend),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item.formattedPrice, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text(item.formattedChange, style: TextStyle(
                  color: item.isPriceUp ? MyColor.mainColor : MyColor.pink4B,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),

        ],
      )
  )
  );
}