class Favorite {
  final int? id;
  final int userId;
  final String coinId;
  final String coinName;
  final String coinSymbol;
  final String coinImage;
  final double priceWhenAdded;
  final DateTime addedAt;

  Favorite({
    this.id,
    required this.userId,
    required this.coinId,
    required this.coinName,
    required this.coinSymbol,
    required this.coinImage,
    required this.priceWhenAdded,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'coin_id': coinId,
      'coin_name': coinName,
      'coin_symbol': coinSymbol,
      'coin_image': coinImage,
      'price_when_added': priceWhenAdded,
      'added_at': addedAt.toIso8601String(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      userId: map['user_id'],
      coinId: map['coin_id'],
      coinName: map['coin_name'],
      coinSymbol: map['coin_symbol'],
      coinImage: map['coin_image'],
      priceWhenAdded: map['price_when_added'],
      addedAt: DateTime.parse(map['added_at']),
    );
  }

  Favorite copyWith({
    int? id,
    int? userId,
    String? coinId,
    String? coinName,
    String? coinSymbol,
    String? coinImage,
    double? priceWhenAdded,
    DateTime? addedAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      coinId: coinId ?? this.coinId,
      coinName: coinName ?? this.coinName,
      coinSymbol: coinSymbol ?? this.coinSymbol,
      coinImage: coinImage ?? this.coinImage,
      priceWhenAdded: priceWhenAdded ?? this.priceWhenAdded,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

class FavoriteWithBalance {
  final Favorite favorite;
  final double currentPrice;
  final double priceChangePercentage24h;

  FavoriteWithBalance({
    required this.favorite,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  double get profitLossPercentage {
    if (favorite.priceWhenAdded == 0) return 0;
    return ((currentPrice - favorite.priceWhenAdded) / favorite.priceWhenAdded) * 100;
  }

  double get profitLossAmount {
    return currentPrice - favorite.priceWhenAdded;
  }

  bool get isProfit => profitLossAmount >= 0;

  String get formattedProfitLoss => '${isProfit ? "+" : ""}\$${profitLossAmount.toStringAsFixed(2)}';
  String get formattedProfitLossPercentage => '${isProfit ? "+" : ""}${profitLossPercentage.toStringAsFixed(2)}%';
}