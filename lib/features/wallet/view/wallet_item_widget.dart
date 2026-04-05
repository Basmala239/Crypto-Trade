import 'package:crypto_trade/core/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors.dart';
import '../../../data/model/favorite_model.dart';

Widget walletItemWidget(FavoriteWithBalance item){
  return Padding(padding: EdgeInsetsGeometry.all(8),
      child: Row(
        children: [
          ClipOval(
             child: SizedBox(width: 40, height: 40,
                 child: Image.network(item.favorite.coinImage)
             ),
          ),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.favorite.coinName.firstTwoWords, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text(item.favorite.coinSymbol, style: TextStyle(
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
              Text(item.formattedProfitLossPercentage, style: TextStyle(
                  color: MyColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
              Text('${item.favorite.priceWhenAdded}', style: TextStyle(
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