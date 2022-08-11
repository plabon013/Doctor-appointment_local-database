import 'package:shared_preferences/shared_preferences.dart';
Future<bool?> setLoginStatus(int id) async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
  return prefs.setInt('user_id', id);
}

 Future<int?> getLoginStatus() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  return  prefs.getInt('user_id');
}