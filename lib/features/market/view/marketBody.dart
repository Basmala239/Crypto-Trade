import 'package:crypto_trade/data/model/responce/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_manager.dart';
import '../../../core/colors.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/error_view.dart';
import '../../../data/model/coin_model.dart';
import '../../../data/model/responce/coin_market.dart';
import '../../../data/services/coin_gecko_service.dart';
import '../../auth/signin/presentation/widgets/signin_tap.dart';
import '../../coin_details/view/coin_detail.dart';
import '../../profile/view/profile_view.dart';
import 'market_item_widget.dart';

class MarketBody extends StatefulWidget {
  const MarketBody({super.key});

  @override
  State<MarketBody> createState() => _MarketBodyState();
}

class _MarketBodyState extends State<MarketBody> {

  int currentIndex = 0;
  List<CoinMarket> _coins = [];
  bool _isLoading = true;
  String? _error;
  final CoinGeckoService _service = CoinGeckoService();

  void updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final coins = await _service.fetchMarketCoins(perPage: 50, page: 1);
      setState(() {
        _coins = coins;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadCoins();
  }


  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return errorView(_error, _refreshData);;
    }

    return Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            customAppBar(context),
            SizedBox(height: 20),
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
                          width: 90),
                      customTap(text: "Spot",
                          isActive: (currentIndex == 1),
                          onClick: () {
                            updateCurrentIndex(1);
                          },
                          width: 90),
                      customTap(text: "Margin",
                          isActive: (currentIndex == 2),
                          onClick: () {
                            updateCurrentIndex(2);
                          },
                          width: 90),
                      customTap(text: "Fiat",
                          isActive: (currentIndex == 3),
                          onClick: () {
                            updateCurrentIndex(3);
                          },
                          width: 90),
                    ]
                )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _coins.length,
                itemBuilder: (BuildContext context, int index) =>
                    marketItemWidget(Coin.fromMarket(_coins[index]),(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinDetailPage(coin: _coins[index]),
                        ),
                      );
                    }),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: MyColor.gray35,),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: MyColor.gray77.withAlpha(10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MyColor.gray77)
              ),
              child: TextButton(onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Icon(Icons.add_circle,color: MyColor.gray77),
                    SizedBox(width: 8,),
                    Text("Add Favorite", style: TextStyle(
                      color: MyColor.gray77,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),)
                  ],)),

            ),
            SizedBox(height: 8,)
          ],
        )
    );
  }
}
