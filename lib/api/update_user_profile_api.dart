import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> updateUserProfileApi({
  required String username,
  required String email,
  required String profileImage,
}) async {
  String apiUrl = '$baseUrl/updateUserProfile';
  print('apiUrl: $apiUrl');
  try {
    var accessToken = await LocalStorage.getAccessToken();
    print('  ${accessToken['accessToken'].toString()}');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': ' ${accessToken['accessToken'].toString()}',
    };
    var url = Uri.parse(apiUrl);

    http.Response response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'username': username,
        'email': email,
        'profileImage': profileImage,
      }),
    );

    if (response.statusCode == 200) {
      print('if response.body:${response.statusCode} ${response.body}');
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } else {
      print(' else response.body:${response.statusCode} ${response.body}');
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    }
  } catch (error) {
    print('error: $error');
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }
}
