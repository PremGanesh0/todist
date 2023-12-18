import 'package:shared_preferences/shared_preferences.dart';
import 'package:todist/model/user_model.dart';

class LocalStorage {
  static Future<void> saveUserData(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data locally
    prefs.setString('userId', userData.id);
    prefs.setString('username', userData.username);
    prefs.setString('email', userData.email);
    // Add more fields as needed
 
  }

  static Future<void> saveTokens(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save tokens locally
    prefs.setString('accessToken', accessToken);
   }

  static Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      id: prefs.getString('userId') ?? '',
      username: prefs.getString('username') ?? '',
      email: prefs.getString('email') ?? '',
      // Add more fields as needed
    );
  }

  static Future<Map<String, String>> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken') ?? '',
    };
  }
}
