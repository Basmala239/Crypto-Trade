import 'package:crypto_trade/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/colors.dart';
import '../../../core/widget/error_view.dart';
import '../../../core/widget/price_chart.dart';
import '../../../data/model/favorite_model.dart';
import '../../../data/model/response/coin_market.dart';
import '../../../data/model/response/market_chart.dart';
import '../../../data/repository/favorite_repository.dart';
import '../../../data/services/coin_gecko_service.dart';
class CoinDetailPage extends StatefulWidget {
  const CoinDetailPage({super.key, required this.coin});
  final CoinMarket coin;
  @override
  State<CoinDetailPage> createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  final CoinGeckoService _service = CoinGeckoService();
  final FavoriteRepository _favoriteRepo = FavoriteRepository();
  late Future<MarketChart> _chartData;
  bool _isFavorite = false;
  bool _isAddingToFavorites = false;

  final UserRepository _userRepo = UserRepository();
  late int? userId;

  @override
  void initState()  {
    super.initState();
    _chartData = _service.fetchMarketChart(widget.coin.id, days: 1);
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    userId = await _userRepo.getUserId();
    final isFav = await _favoriteRepo.isFavorite(userId!, widget.coin.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isAddingToFavorites = true;
    });

    try {
      if (_isFavorite) {
        await _favoriteRepo.removeFavorite(userId!, widget.coin.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.coin.name} removed from wallet'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );
          setState(() {
            _isFavorite = false;
          });
        }
      } else {
        final favorite = Favorite(
          userId: userId!,
          coinId: widget.coin.id,
          coinName: widget.coin.name,
          coinSymbol: widget.coin.symbol,
          coinImage: widget.coin.image,
          priceWhenAdded: widget.coin.currentPrice,
          addedAt: DateTime.now(),
        );

        await _favoriteRepo.addFavorite(favorite);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.coin.name} added to wallet'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          setState(() {
            _isFavorite = true;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToFavorites = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.coin.image,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.currency_bitcoin, size: 20),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coin.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.coin.symbol.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColor.gray77,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _isAddingToFavorites
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: MyColor.mainColor,
              ),
            )
                : IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : MyColor.gray77,
                size: 28,
              ),
              onPressed: _toggleFavorite,
              tooltip: _isFavorite ? 'Remove from wallet' : 'Add to wallet',
            ),
          ),
        ],
        centerTitle: false,
        backgroundColor: MyColor.secondaryColor,
        elevation: 0,
      ),
      body: FutureBuilder<MarketChart>(
        future: _chartData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return errorView(snapshot.error.toString(), () {
              setState(() {
                _chartData = _service.fetchMarketChart(widget.coin.id, days: 1);
              });
            });
          }

          final chartData = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PriceChart(
                  chartData: chartData,
                  coinSymbol: widget.coin.symbol,
                  currentPrice: widget.coin.currentPrice,
                ),
                const SizedBox(height: 16),
                _buildInfoCard(),
                const SizedBox(height: 16),
                _buildActionButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoRow('Market Cap', widget.coin.formattedMarketCap),
          const SizedBox(height: 12),
          _buildInfoRow('Market Cap Rank', '#${widget.coin.marketCapRank}'),
          const SizedBox(height: 12),
          _buildInfoRow('24h High', '\$${widget.coin.high24h?.toStringAsFixed(2) ?? 'N/A'}'),
          const SizedBox(height: 12),
          _buildInfoRow('24h Low', '\$${widget.coin.low24h?.toStringAsFixed(2) ?? 'N/A'}'),
          const SizedBox(height: 12),
          _buildInfoRow('Current Price', widget.coin.formattedPrice),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: MyColor.gray77,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _isAddingToFavorites
              ? Container(
            height: 50,
            decoration: BoxDecoration(
              color: MyColor.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
              : GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: _isFavorite
                    ? Colors.red.withOpacity(0.2)
                    : MyColor.mainColor,
                borderRadius: BorderRadius.circular(12),
                border: _isFavorite
                    ? Border.all(color: Colors.red, width: 1)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isFavorite ? 'In Wallet' : 'Add to Wallet',
                    style: TextStyle(
                      color: _isFavorite ? Colors.red : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buy feature coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}