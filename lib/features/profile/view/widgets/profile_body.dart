import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/colors.dart';
import 'package:crypto_trade/features/profile/view/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/profile_item_model.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});

  final List<ProfileItemModel> items = [
    ProfileItemModel(label: "Name", value: "Basmala23"),
    ProfileItemModel(label: "Email", value: "abuziedbasmala@gmail.com"),
    ProfileItemModel(label: "Mobile Number", value: "+20 1234567890"),
    ProfileItemModel(label: "Password", value: "******"),
    ProfileItemModel(label: "Setting", value: ""),
  ];


  @override
  Widget build(BuildContext context) {
    return

      Stack(
        children: [
          Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColor.backgroundColor,
                      MyColor.mainColor.withAlpha(25),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: MyColor.gray77),
                      onPressed: () {
                        Navigator.pop(context);
                      },),
                    SizedBox(width: 5),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: MyColor.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(18),
                alignment: Alignment.topLeft,
                width: double.infinity,
                height: 500,
                child: ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          profileItem(items[index], context),
                        ],
                      ),

                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: MyColor.gray77),
                ),
              )
            ],
          ),

          Positioned(
            top: 100,
            left: 160,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: MyColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipOval(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(AssetsManager.profile),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Basmala23",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: MyColor.white,
                  ),
                )
              ],
            ),
          ),
        ],
      );
  }
}
