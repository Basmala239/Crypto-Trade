import 'package:flutter/material.dart';

import '../../../../core/assets_manager.dart';
import '../../../../data/model/home_grid_item_model.dart';
import 'menu_app_bar.dart';
import 'menu_section.dart';

class MenuBody extends StatelessWidget {
  MenuBody({super.key});

  final List<HomeGridItemModel> commonList = [
    HomeGridItemModel(
        icon: AssetsManager.transfer, label: "Transfer", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.deposit, label: "Deposit", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.orders, label: "Orders", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.referral, label: "Referral", onClick: () {})
  ];
  final List<HomeGridItemModel> tradeList = [
    HomeGridItemModel(
        icon: AssetsManager.convert, label: "Convert", onClick: () {}),
    HomeGridItemModel(icon: AssetsManager.spot, label: "Spot", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.margin, label: "Margin", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.gridTrading, label: "Grid Trading", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.liquidSwap, label: "Liquid Swap", onClick: () {})
  ];
  final List<HomeGridItemModel> financeList = [
    HomeGridItemModel(
        icon: AssetsManager.savings, label: "Savings", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.staking, label: "Staking", onClick: () {}),
    HomeGridItemModel(icon: AssetsManager.pay, label: "Pay", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.cryptoLoans, label: "Crypto Loans", onClick: () {}),
    HomeGridItemModel(icon: AssetsManager.pool, label: "Pool", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.eth, label: "ETH 2.0", onClick: () {}),
    HomeGridItemModel(
        icon: AssetsManager.launchpad, label: "launchpad", onClick: () {})
  ];

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              menuAppBar(context),
              SizedBox(height: 24,),
              menuSection("Common", commonList),
              menuSection("Trade", tradeList),
              menuSection("Finance", financeList),
            ],
          )
    );
  }
}
