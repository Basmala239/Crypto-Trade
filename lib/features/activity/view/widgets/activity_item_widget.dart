import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/coin_model.dart';

Widget activityItem(CoinModel item) {
  return Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 4),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: item.isGood ? MyColor.mainColor.withAlpha(10) : MyColor.pink4B.withAlpha(10),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            item.isGood ? "L/B" : "L/S",
            style: TextStyle(
              color: item.isGood ? MyColor.mainColor : MyColor.pink4B,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item.type, style: TextStyle(color: MyColor.white, fontSize: 14, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text("2021-08-02 04:39:26", style: TextStyle(color: MyColor.gray77, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, color: MyColor.grayB7, size: 12),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Amount", style: TextStyle(color: MyColor.gray77, fontSize: 14, fontWeight: FontWeight.w400)),
                    Text("Price", style: TextStyle(color: MyColor.gray77, fontSize: 14, fontWeight: FontWeight.w400)),
                    Text("Status", style: TextStyle(color: MyColor.gray77, fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text("0.49975", style: TextStyle(color: MyColor.mainColor, fontSize: 14, fontWeight: FontWeight.w700)),
                        Text("/0.49975", style: TextStyle(color: MyColor.grayB7, fontSize: 14, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Text(item.percent, style: TextStyle(color: MyColor.grayB7, fontSize: 14, fontWeight: FontWeight.w700)),
                    Text(
                      item.isGood ? "Filled" : "Cancelled",
                      style: TextStyle(color: item.isGood ? MyColor.mainColor : MyColor.pink4B, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  )
  );
}