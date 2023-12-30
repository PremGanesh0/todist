import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> refreshTokenApi({required String userId}) async {
  String apiUrl = '$baseUrl/refresh-token';
  var refreshToken = await LocalStorage.getAccessToken();
  try {
    var headers = {
      'Authorization': refreshToken['refreshToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({"userId": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  } catch (error) {
    debugPrint(error.toString());
  }
}
