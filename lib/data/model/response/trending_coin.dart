class TrendingCoin {
  final String id;
  final String name;
  final String symbol;
  final String thumb;
  final int? marketCapRank;
  final double price;
  final double priceChangePercentage24h;

  TrendingCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    this.marketCapRank,
    required this.price,
    required this.priceChangePercentage24h,
  });

  factory TrendingCoin.fromJson(Map<String, dynamic> json) {
    final item = json['item'] as Map<String, dynamic>;
    final data = item['data'] as Map<String, dynamic>?;

    return TrendingCoin(
      id: item['id'] ?? '',
      name: item['name'] ?? '',
      symbol: item['symbol']?.toUpperCase() ?? '',
      thumb: item['thumb'] ?? '',
      marketCapRank: item['market_cap_rank'],
      price: (data?['price'] ?? 0).toDouble(),
      priceChangePercentage24h: (data?['price_change_percentage_24h']?['usd'] ?? 0).toDouble(),
    );
  }

  bool get isPriceUp => priceChangePercentage24h >= 0;
  String get formattedPrice => '\$${price.toStringAsFixed(price < 1 ? 4 : 2)}';
  String get formattedChange => '${priceChangePercentage24h.toStringAsFixed(2)}%';
}
