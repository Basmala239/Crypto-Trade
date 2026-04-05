import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  Future<void> setUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userid', id);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userid');
  }
  Future<void> setFirstVisitCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstVisit', false);
  }

  Future<bool?> getIsFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstVisit');
  }

  Future<void> setRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', rememberMe);
  }

  Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe');
  }

}