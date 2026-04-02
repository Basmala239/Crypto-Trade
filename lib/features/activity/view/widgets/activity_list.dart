import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../../data/model/coin_model.dart';
import 'activity_item_widget.dart';

Widget activityList() {
  return ListView.separated(
    padding: EdgeInsets.symmetric(vertical: 5),
    itemBuilder: (context, index) => activityItem(CoinModel.coinList[index]),
    separatorBuilder: (context, index) => Divider(color: MyColor.gray77),
    itemCount: CoinModel.coinList.length,
  );
}