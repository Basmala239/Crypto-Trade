import 'package:crypto_trade/core/assets_manager.dart';
import 'package:crypto_trade/core/widget/empty_view.dart';
import 'package:crypto_trade/features/wallet/view/wallet_item_widget.dart';
import 'package:crypto_trade/features/wallet/view/wallet_top_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../data/model/coin_model.dart';
import '../../../data/model/favorite_model.dart';
import '../../../data/repository/favorite_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../auth/sign_in/presentation/widgets/sign_in_tap.dart';


class WalletBody extends StatefulWidget {
  const WalletBody({super.key});

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  int currentIndex = 0;
  final FavoriteRepository _favoriteRepo = FavoriteRepository();
  final UserRepository _userRepo = UserRepository();

  List<FavoriteWithBalance> _favorites = [];
  bool _isLoading = true;
  double _totalValue = 0;
  double _totalProfitLoss = 0;

  late int? userId;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    userId = await _userRepo.getUserId();
    setState(() {
      _isLoading = true;
    });

    try {
      final favorites = await _favoriteRepo.getUserFavoritesWithBalance(userId!);
      final totalValue = await _favoriteRepo.getTotalPortfolioValue(userId!);
      final totalProfitLoss = await _favoriteRepo.getTotalProfitLoss(userId!);

      setState(() {
        _favorites = favorites;
        _totalValue = totalValue;
        _totalProfitLoss = totalProfitLoss;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading favorites: $e');
    }
  }

  void updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _favorites.isEmpty
        ? emptyView(AssetsManager.noNotification, "No wallets yet",
        "Let's add wallets from market")
        :
    Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            walletAppBar(_totalValue.toStringAsFixed(2)),
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
                itemCount: _favorites.length,
                itemBuilder: (BuildContext context, int index) =>
                    walletItemWidget(_favorites[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: MyColor.gray35,),
              ),
            ),
          ],
        )
    );
  }
}
