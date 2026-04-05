import '../model/favorite_model.dart';
import '../model/response/coin_market.dart';
import '../model/user.dart';
import '../repository/favorite_repository.dart';
import '../repository/user_repository.dart';

class AuthService {
  final UserRepository _userRepo = UserRepository();
  final FavoriteRepository _favoriteRepo = FavoriteRepository();

  Future<User?> register(String name, String email, String password) async {
    final user = User(
      name: name,
      email: email,
      password: password,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await _userRepo.createUser(user);
  }

  Future<User?> login(String email, String password) async {
    return await _userRepo.authenticateUser(email, password);
  }

  Future<void> addFavorite(int userId, CoinMarket coin) async {
    final favorite = Favorite(
      userId: userId,
      coinId: coin.id,
      coinName: coin.name,
      coinSymbol: coin.symbol,
      coinImage: coin.image,
      priceWhenAdded: coin.currentPrice,
      addedAt: DateTime.now(),
    );

    await _favoriteRepo.addFavorite(favorite);
  }

  Future<void> removeFavorite(int userId, String coinId) async {
    await _favoriteRepo.removeFavorite(userId, coinId);
  }

  Future<bool> isFavorite(int userId, String coinId) async {
    return await _favoriteRepo.isFavorite(userId, coinId);
  }
}