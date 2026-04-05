import 'package:crypto_trade/data/model/response/coin.dart';
import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/error_view.dart';
import '../../../data/model/response/coin_market.dart';
import '../../../data/services/coin_gecko_service.dart';
import '../../auth/sign_in/presentation/widgets/sign_in_tap.dart';
import '../../coin_details/view/coin_detail.dart';
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
      return errorView(_error, _refreshData);
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
          ],
        )
    );
  }
}
