import 'package:crypto_trade/features/activity/view/activity_body.dart';
import 'package:crypto_trade/features/home/view/widget/custom_bottom_nav_bar.dart';
import 'package:crypto_trade/features/home/view/widget/home_body.dart';
import 'package:crypto_trade/features/market/view/market_body.dart';
import 'package:crypto_trade/features/wallet/view/wallet_body.dart';
import 'package:flutter/material.dart';
import '../../../core/assets_manager.dart';
import '../../../core/colors.dart';
import '../../../data/model/home_grid_item_model.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  Widget currentScreen=HomeBody();

  void updateCurrentIndex(int index){
    setState(() {
      currentIndex=index;
      switch(currentIndex){
        case 0: currentScreen=HomeBody();
        case 1: currentScreen = MarketBody();
        case 3: currentScreen = ActivityBody();
        case 4: currentScreen = WalletBody();
        default: currentScreen=Center(
          child: Text("Coming Soon", style: TextStyle(
            color: MyColor.mainColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          )),
        );
      }
    });
  }
  late final List<HomeGridItemModel> navItems=[
    HomeGridItemModel(icon: AssetsManager.home, label: "Home",onClick: (){updateCurrentIndex(0);}),
    HomeGridItemModel(icon: AssetsManager.markets, label: "Markets",onClick: (){updateCurrentIndex(1);}),
    HomeGridItemModel(icon: AssetsManager.trades, label: "Trades",onClick: (){updateCurrentIndex(2);}),
    HomeGridItemModel(icon: AssetsManager.activity, label: "Activity",onClick: (){updateCurrentIndex(3);}),
    HomeGridItemModel(icon: AssetsManager.wallets, label: "Wallets",onClick: (){updateCurrentIndex(4);}),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: MyColor.secondaryColor,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomNavBarItem(currentIndex == 0, navItems[0]),
              bottomNavBarItem(currentIndex == 1, navItems[1]),
              bottomNavBarItem(currentIndex == 2, navItems[2]),
              bottomNavBarItem(currentIndex == 3, navItems[3]),
              bottomNavBarItem(currentIndex == 4, navItems[4])
            ]
        ),

      ),
    );
  }
}
