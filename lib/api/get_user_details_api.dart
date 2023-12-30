import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/api/registration_api.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> getUserDetails({required String userId}) async {
  String apiUrl = '$baseUrl/getUserDetails';
  var accessToken = await LocalStorage.getAccessToken();

  try {
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(apiUrl));
    request.body = json.encode({"userId": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var decodeData = jsonDecode(data);
      User(
        id: userId,
        username: decodeData['data']['username'],
        email: decodeData['data']['email'],
        profileImage: decodeData['data']['profileImage'],
      ).copyWith();
      saveUserData(User(
          id: userId,
          username: decodeData['data']['username'],
          email: decodeData['data']['email'],
          profileImage: decodeData['data']['profileImage']));
    } else {}
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString(), toastLength: Toast.LENGTH_LONG);
  }
}
