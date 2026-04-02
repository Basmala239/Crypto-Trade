import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/data/model/setting_item_model.dart';
import 'package:crypto_trade/features/setting/view/widgets/settings_item_widget.dart';
import 'package:flutter/material.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});

  final List<SettingItemModel> items = [
    SettingItemModel(
        icon: AssetsManager.language, label: "Language", value: "English"),
    SettingItemModel(
        icon: AssetsManager.currency, label: "Currency", value: "USD"),
    SettingItemModel(icon: AssetsManager.appearance,
        label: "Appearance",
        value: "Use Device Settings"),
    SettingItemModel(icon: AssetsManager.preference,
        label: "Preference",
        value: "Customize"),
    SettingItemModel(
        icon: AssetsManager.aboutUs, label: "About Us", value: "v1.2.3"),

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(16),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) =>
                Column(
                    children: [
                      SizedBox(height: 10,),
                      settingItem(items[index]),
                      SizedBox(height: 10,),
                      if(index != items.length - 1)
                        Divider(thickness: 1, color: MyColor.gray77,),
                    ]
                )
        )
    );
  }
}
