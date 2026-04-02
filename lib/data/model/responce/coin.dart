// This can be used if you want a unified representation
import 'package:crypto_trade/data/model/responce/trending_coin.dart';

import 'coin_market.dart';

class Coin {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double currentPrice;
  final double priceChangePercentage24h;
  final int? marketCapRank;
  final bool isTrending;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.marketCapRank,
    this.isTrending = false,
  });

  // Convert from CoinMarket
  factory Coin.fromMarket(CoinMarket market, {bool isTrending = false}) {
    return Coin(
      id: market.id,
      name: market.name,
      symbol: market.symbol,
      imageUrl: market.image,
      currentPrice: market.currentPrice,
      priceChangePercentage24h: market.priceChangePercentage24h,
      marketCapRank: market.marketCapRank,
      isTrending: isTrending,
    );
  }

  // Convert from TrendingCoin
  factory Coin.fromTrending(TrendingCoin trending, {bool isTrending = true}) {
    return Coin(
      id: trending.id,
      name: trending.name,
      symbol: trending.symbol,
      imageUrl: trending.thumb,
      currentPrice: trending.price,
      priceChangePercentage24h: trending.priceChangePercentage24h,
      marketCapRank: trending.marketCapRank,
      isTrending: isTrending,
    );
  }

  String get formattedPrice => '\$${currentPrice.toStringAsFixed(currentPrice < 1 ? 4 : 2)}';
  String get formattedChange => '${priceChangePercentage24h.toStringAsFixed(2)}%';
  bool get isPriceUp => priceChangePercentage24h >= 0;
}