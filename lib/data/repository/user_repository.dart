import '../datasource/local/PrefsHelper.dart';
import '../datasource/local/database_helper.dart';
import '../model/user.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final PrefsHelper _prefsHelper = PrefsHelper();


  Future<void> setUserId(int id) async {
    await _prefsHelper.setUserId(id);
  }
  Future<int?> getUserId() async {
    return await _prefsHelper.getUserId();
  }
  Future<void> setFirstVisitCompleted() async {
    await _prefsHelper.setFirstVisitCompleted();
  }
  Future<bool?> getIsFirstVisit() async {
    return await _prefsHelper.getIsFirstVisit();
  }
  Future<void> setRememberMe(bool rememberMe) async {
    await _prefsHelper.setRememberMe(rememberMe);
  }
  Future<bool?> getRememberMe() async {
    return await _prefsHelper.getRememberMe();
  }

  Future<void> logout() async {
    await _prefsHelper.setRememberMe(false);
  }



  Future<User> createUser(User user) async {
    final db = await _dbHelper.database;
    final id = await db.insert('users', user.toMap());
    return user.copyWith(id: id);
  }

  Future<User?> getUserById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return maps.map((map) => User.fromMap(map)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'users',
      user.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePassword(int userId, String newPassword) async {
    final db = await _dbHelper.database;
    final user = await getUserById(userId);
    if (user != null) {
      return await db.update(
        'users',
        user.copyWith(
          password: newPassword,
          updatedAt: DateTime.now(),
        ).toMap(),
        where: 'id = ?',
        whereArgs: [userId],
      );
    }
    return 0;
  }
  Future<int> updateUserImage(int userId, String imageUrl) async {
    final db = await _dbHelper.database;
    final user = await getUserById(userId);
    if (user != null) {
      return await db.update(
        'users',
        user.copyWith(
          imageUrl: imageUrl,
          updatedAt: DateTime.now(),
        ).toMap(),
        where: 'id = ?',
        whereArgs: [userId],
      );
    }
    return 0;
  }

  Future<bool> isEmailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }

  Future<User?> authenticateUser(String email, String password) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}