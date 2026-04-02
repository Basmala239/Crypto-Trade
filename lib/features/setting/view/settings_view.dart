import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/setting/view/widgets/settings_body.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: MyColor.gray77,), ),
        title: Text("Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: MyColor.grayB7,
          ),
        ),
      ),
      body: SettingsBody(),
    );
  }
}
