import 'package:sqflite/sqflite.dart';

import '../datasource/local/database_helper.dart';
import '../services/coin_gecko_service.dart';
import '../model/favorite_model.dart';

class FavoriteRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final CoinGeckoService _coinService = CoinGeckoService();


  Future<Favorite> addFavorite(Favorite favorite) async {
    final db = await _dbHelper.database;
    final id = await db.insert(
      'favorites',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return favorite.copyWith(id: id);
  }

  Future<int> removeFavorite(int userId, String coinId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'favorites',
      where: 'user_id = ? AND coin_id = ?',
      whereArgs: [userId, coinId],
    );
  }

  Future<bool> isFavorite(int userId, String coinId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'user_id = ? AND coin_id = ?',
      whereArgs: [userId, coinId],
    );
    return maps.isNotEmpty;
  }

  Future<List<Favorite>> getUserFavorites(int userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'added_at DESC',
    );

    return maps.map((map) => Favorite.fromMap(map)).toList();
  }

  Future<List<FavoriteWithBalance>> getUserFavoritesWithBalance(int userId) async {
    final favorites = await getUserFavorites(userId);
    final List<FavoriteWithBalance> favoritesWithBalance = [];

    for (final favorite in favorites) {
      try {
        final marketData = await _coinService.fetchMarketCoins(
          perPage: 1,
          page: 1,
        );

        final currentCoin = marketData.firstWhere(
              (coin) => coin.id == favorite.coinId,
          orElse: () => throw Exception('Coin not found'),
        );

        favoritesWithBalance.add(
          FavoriteWithBalance(
            favorite: favorite,
            currentPrice: currentCoin.currentPrice,
            priceChangePercentage24h: currentCoin.priceChangePercentage24h,
          ),
        );
      } catch (e) {
        print('Error fetching price for ${favorite.coinId}: $e');
        favoritesWithBalance.add(
          FavoriteWithBalance(
            favorite: favorite,
            currentPrice: favorite.priceWhenAdded,
            priceChangePercentage24h: 0,
          ),
        );
      }
    }

    return favoritesWithBalance;
  }

  Future<double> getTotalPortfolioValue(int userId) async {
    final favoritesWithBalance = await getUserFavoritesWithBalance(userId);
    double totalValue = 0;

    for (final item in favoritesWithBalance) {
      totalValue += item.currentPrice;
    }

    return totalValue;
  }

  Future<double> getTotalProfitLoss(int userId) async {
    final favoritesWithBalance = await getUserFavoritesWithBalance(userId);
    double totalProfitLoss = 0;

    for (final item in favoritesWithBalance) {
      totalProfitLoss += item.profitLossAmount;
    }

    return totalProfitLoss;
  }

  Future<int> getFavoriteCount(int userId) async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM favorites WHERE user_id = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<FavoriteWithBalance?> getBestPerformingFavorite(int userId) async {
    final favorites = await getUserFavoritesWithBalance(userId);
    if (favorites.isEmpty) return null;

    return favorites.reduce((best, current) {
      return current.profitLossPercentage > best.profitLossPercentage ? current : best;
    });
  }

  Future<FavoriteWithBalance?> getWorstPerformingFavorite(int userId) async {
    final favorites = await getUserFavoritesWithBalance(userId);
    if (favorites.isEmpty) return null;

    return favorites.reduce((worst, current) {
      return current.profitLossPercentage < worst.profitLossPercentage ? current : worst;
    });
  }

  Future<void> addMultipleFavorites(List<Favorite> favorites) async {
    final db = await _dbHelper.database;
    Batch batch = db.batch();

    for (final favorite in favorites) {
      batch.insert('favorites', favorite.toMap());
    }

    await batch.commit();
  }

  Future<int> removeAllFavorites(int userId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'favorites',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}