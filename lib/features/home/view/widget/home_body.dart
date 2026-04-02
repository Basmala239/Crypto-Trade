import 'package:crypto_trade/core/widget/error_view.dart';
import 'package:crypto_trade/data/model/home_grid_item_model.dart';
import 'package:crypto_trade/data/model/option_item_model.dart';
import 'package:crypto_trade/features/menu/view/menu_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/assets_manager.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../data/model/responce/coin.dart';
import '../../../../data/model/responce/coin_market.dart';
import '../../../../data/model/responce/trending_coin.dart';
import '../../../../data/services/coin_gecko_service.dart';
import 'coin_item.dart';
import 'home_grid_item_widget.dart';
import 'option_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final CoinGeckoService _service = CoinGeckoService();

  final List<OptionItemModel> optionItems = [
    OptionItemModel(image: AssetsManager.rocket,
        title: "P2P Trading",
        subTitle: "Bank Transfer, Paypal Revolut..."),
    OptionItemModel(image: AssetsManager.credit,
        title: "Credit/Debit Card",
        subTitle: "Visa, Mastercard")
  ];
  List<CoinMarket>? _topCoins;
  List<TrendingCoin>? _trendingCoins;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        _service.fetchTopCoins(perPage: 20, page: 1),
        _service.fetchTrendingCoins(),
      ]);

      setState(() {
        _topCoins = results[0] as List<CoinMarket>;
        _trendingCoins = results[1] as List<TrendingCoin>;
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
    await _loadData();
  }


  @override
  Widget build(BuildContext context) {
    final List<HomeGridItemModel> homeGridItems = [
      HomeGridItemModel(icon: AssetsManager.deposit, label: "Deposit",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.referral, label: "Referral",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.gridTrading, label: "Grid Trading",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.margin, label: "Margin",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.launchpad, label: "Launchpad",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.savings, label: "savings",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.liquidSwap, label: "Liquid Swap",onClick: (){}),
      HomeGridItemModel(icon: AssetsManager.more, label: "More",onClick: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuView()));
      }),
    ];
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return errorView(_error, _refreshData);
    }

    return
      SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              customAppBar(context),
              SizedBox(
                height: 270,
                width: double.infinity,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: homeGridItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return homeGridItemWidget(homeGridItems[index]);
                    }
                ),
              ),
              optionWidget(optionItems[0]),
              SizedBox(height: 16,),
              optionWidget(optionItems[1]),
              SizedBox(height: 24,),
              Text("Recent Coin",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),),
              SizedBox(height: 8,),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _trendingCoins!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      coinItemWidget(Coin.fromTrending(_trendingCoins![index])),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 16,),
                ),

              ),
              SizedBox(height: 20,),
              Text("Top Coins",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),),
              SizedBox(height: 8,),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _topCoins!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      coinItemWidget(Coin.fromMarket(_topCoins![index])),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 16,),
                ),

              ),
            ],
          )
      );
  }
}
