import 'package:crypto_trade/features/wallet/view/wallet_item_widget.dart';
import 'package:crypto_trade/features/wallet/view/wallet_top_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/assets_manager.dart';
import '../../../core/colors.dart';
import '../../../data/model/coin_model.dart';
import '../../auth/signin/presentation/widgets/signin_tap.dart';


class WalletBody extends StatefulWidget {
  const WalletBody({super.key});

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  int currentIndex = 0;
  void updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            walletAppBar(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColor.secondaryColor,
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customTap(text: "Convert",
                          isActive: (currentIndex == 0),
                          onClick: () {
                            updateCurrentIndex(0);
                          },
                          width: 120,
                      color: MyColor.mainColor),
                      customTap(text: "Spot",
                          isActive: (currentIndex == 1),
                          onClick: () {
                            updateCurrentIndex(1);
                          },
                          width: 120,
                          color: MyColor.mainColor),
                      customTap(text: "Margin",
                          isActive: (currentIndex == 2),
                          onClick: () {
                            updateCurrentIndex(2);
                          },
                          width: 120,
                          color: MyColor.mainColor),

                    ]
                )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: CoinModel.coinList.length,
                itemBuilder: (BuildContext context, int index) =>
                    walletItemWidget(CoinModel.coinList[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: MyColor.gray35,),
              ),
            ),
          ],
        )
    );
  }
}
