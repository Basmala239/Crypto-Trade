class CoinMarket {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double priceChangePercentage24h;
  final double? high24h;
  final double? low24h;

  CoinMarket({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
    this.high24h,
    this.low24h,
  });

  factory CoinMarket.fromJson(Map<String, dynamic> json) {
    return CoinMarket(
      id: json['id'] ?? '',
      symbol: json['symbol']?.toUpperCase() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      marketCapRank: json['market_cap_rank'] ?? 0,
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0).toDouble(),
      high24h: (json['high_24h'] ?? 0).toDouble(),
      low24h: (json['low_24h'] ?? 0).toDouble(),
    );
  }

  bool get isPriceUp => priceChangePercentage24h >= 0;
  String get formattedPrice => '\$${currentPrice.toStringAsFixed(2)}';
  String get formattedMarketCap => _formatNumber(marketCap);
  String get formattedChange => '${priceChangePercentage24h.toStringAsFixed(2)}%';

  String _formatNumber(double number) {
    if (number >= 1e9) {
      return '\$${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '\$${(number / 1e6).toStringAsFixed(2)}M';
    } else {
      return '\$${number.toStringAsFixed(0)}';
    }
  }
}