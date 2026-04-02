import 'package:crypto_trade/core/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets_manager.dart';

Widget menuAppBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back, color: MyColor.gray77,)),
                Text("Menu", style: TextStyle(
                    color: MyColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),),
                Spacer(),
                IconButton(onPressed: () {},
                    icon: Icon(Icons.menu_outlined, color: MyColor.gray77,))
              ]
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Image.asset(AssetsManager.profile),
                ),
              ),
              SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Basmala23", style: TextStyle(color: MyColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),),
                  Row(
                    children: [
                      Text("ID: 1234567890",
                        style: TextStyle(color: MyColor.gray77,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),),
                      SizedBox(width: 8,),
                      Icon(Icons.copy, color: MyColor.mainColor, size: 10,)
                    ],
                  )
                ],
              ),
              Spacer(),
              ElevatedButton(onPressed: () {

              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.mainColor),
                  child: Text("Edit Profile", style: TextStyle(
                      color: MyColor.backgroundColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14))
              )

            ],
          )
        ],
      )
  );
}