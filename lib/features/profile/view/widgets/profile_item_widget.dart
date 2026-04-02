import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/data/model/profile_item_model.dart';
import 'package:flutter/material.dart';

import '../../../setting/view/settings_view.dart';

Widget profileItem(ProfileItemModel item,BuildContext context ) {
  return GestureDetector(
      onTap: () {
        if (item.label == "Setting") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
        }
      },
      child: Row(
        children: [
          Text(item.label,
            style: TextStyle(
              color: MyColor.grayCD,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),),
          Spacer(),
          Text(item.value,
            style: TextStyle(
              color: MyColor.gray77,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),),
          SizedBox(width: 5,),
          Icon(Icons.arrow_forward, color: MyColor.gray77,),
        ],
      )
  );
}