import 'package:shared_preferences/shared_preferences.dart';
import 'package:todist/model/user_model.dart';

class LocalStorage {
  static const String userIdKey = 'userId';
  static const String usernameKey = 'username';
  static const String emailKey = 'email';
  static const String profileImageKey = 'profileImage';
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';

  static Future<void> saveUserData(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data locally
    prefs.setString(userIdKey, userData.id);
    prefs.setString(usernameKey, userData.username);
    prefs.setString(emailKey, userData.email);
    prefs.setString(profileImageKey, userData.profileImage);
    // Add more fields as needed
  }

  static Future<void> saveAccessTokens(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(accessTokenKey, accessToken);
  }

  static Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      id: prefs.getString(userIdKey) ?? '',
      username: prefs.getString(usernameKey) ?? '',
      email: prefs.getString(emailKey) ?? '',
      profileImage: prefs.getString(profileImageKey) ?? '',
      // Add more fields as needed
    );
  }

  static Future<Map<String, String>> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      accessTokenKey: prefs.getString(accessTokenKey) ?? '',
    };
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(refreshTokenKey, refreshToken);
  }
}
