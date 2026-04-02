import 'package:crypto_trade/data/model/setting_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_manager.dart';
import '../../../../core/colors.dart';
import '../../../setting/view/widgets/settings_item_widget.dart';

Widget headerItems() {
  List<SettingItemModel> items = [
    SettingItemModel(icon: AssetsManager.coin, label: "Deposit", value: ''),
    SettingItemModel(icon: AssetsManager.withdrawals, label: "Withdrawals", value:''),
    SettingItemModel(icon: AssetsManager.shoppingCart, label: "Buy Order", value:'')
];
  return Container(
    alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColor.secondaryColor,
      ),
      width: double.infinity,
      height: 170,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => settingItem(items[index]),
          separatorBuilder: (context, index) => Divider(color: MyColor.gray77,),
          itemCount: items.length
      )
  );
}