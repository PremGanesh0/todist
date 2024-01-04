import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/api/registration_api.dart';
import 'package:todist/utils.dart';

Future<void> refreshApi() async {
  String apiUrl = '$baseUrl/refresh-token';
  var refreshToken = await LocalStorage.getRefreshToken();
  var accessToken = await LocalStorage.getAccessToken();

  try {
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "refreshToken": refreshToken['refreshToken'].toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var decodedData = json.decode(data);
      var accessToken = decodedData['data']['accessToken'];

      saveAccessToken(accessToken);
    } else {}
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
  }
}
