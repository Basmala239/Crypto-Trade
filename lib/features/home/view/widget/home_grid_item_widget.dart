import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/data/model/home_grid_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget homeGridItemWidget(HomeGridItemModel item) {
  return GestureDetector(
    onTap: item.onClick,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MyColor.secondaryColor,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(item.icon),
            Text(item.label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.grayCD
              ),)
          ],
        ),
      )
  );
}