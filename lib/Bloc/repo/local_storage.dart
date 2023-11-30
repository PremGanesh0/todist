import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data locally
    prefs.setString('userId', userData['id']);
    prefs.setString('username', userData['username']);
    prefs.setString('email', userData['email']);
    // Add more fields as needed
  }

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save tokens locally
    prefs.setString('accessToken', accessToken);
    prefs.setString('refreshToken', refreshToken);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString('userId'),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      // Add more fields as needed
    };
  }

  static Future<Map<String, String>> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken') ?? '',
      'refreshToken': prefs.getString('refreshToken') ?? '',
    };
  }
}
