import 'package:crypto_trade/data/model/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_manager.dart';
import '../../../core/colors.dart';

Widget walletItemWidget(CoinModel item){
  return Padding(padding: EdgeInsetsGeometry.all(8),
      child: Row(
        children: [
          SvgPicture.asset(item.icon, width: 40, height: 40,),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.label, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text(item.type, style: TextStyle(
                  color: MyColor.gray77,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item.price, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text(item.total, style: TextStyle(
                  color: MyColor.gray77,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),

        ],
      )
  );
}