class MarketChart {
  final List<PricePoint> prices;
  final List<MarketCapPoint> marketCaps;
  final List<VolumePoint> volumes;

  MarketChart({
    required this.prices,
    required this.marketCaps,
    required this.volumes,
  });

  factory MarketChart.fromJson(Map<String, dynamic> json) {
    return MarketChart(
      prices: (json['prices'] as List)
          .map((item) => PricePoint.fromJson(item))
          .toList(),
      marketCaps: (json['market_caps'] as List)
          .map((item) => MarketCapPoint.fromJson(item))
          .toList(),
      volumes: (json['total_volumes'] as List)
          .map((item) => VolumePoint.fromJson(item))
          .toList(),
    );
  }

  // Get min and max prices for chart scaling
  double get minPrice => prices.map((p) => p.price).reduce((a, b) => a < b ? a : b);
  double get maxPrice => prices.map((p) => p.price).reduce((a, b) => a > b ? a : b);

  // Get price change over the period
  double get priceChange => prices.last.price - prices.first.price;
  double get priceChangePercentage => (priceChange / prices.first.price) * 100;

  // Check if price went up or down
  bool get isPriceUp => priceChange >= 0;
}

class PricePoint {
  final DateTime timestamp;
  final double price;

  PricePoint({
    required this.timestamp,
    required this.price,
  });

  factory PricePoint.fromJson(List<dynamic> json) {
    return PricePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0].toInt()),
      price: json[1].toDouble(),
    );
  }
}

class MarketCapPoint {
  final DateTime timestamp;
  final double marketCap;

  MarketCapPoint({
    required this.timestamp,
    required this.marketCap,
  });

  factory MarketCapPoint.fromJson(List<dynamic> json) {
    return MarketCapPoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0].toInt()),
      marketCap: json[1].toDouble(),
    );
  }
}

class VolumePoint {
  final DateTime timestamp;
  final double volume;

  VolumePoint({
    required this.timestamp,
    required this.volume,
  });

  factory VolumePoint.fromJson(List<dynamic> json) {
    return VolumePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0].toInt()),
      volume: json[1].toDouble(),
    );
  }
}