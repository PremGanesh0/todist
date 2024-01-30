import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> updateUserProfileApi(
    {required String username,
    required String email,
    required String profileImage,
    String? password}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/updateUserProfile';

  var accessToken = await LocalStorage.getAccessToken();
  var headers = {'Authorization': accessToken['accessToken'].toString()};
  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    var params;
    if (password == null) {
      params = {
        'username': username,
        'email': email,
      };
    } else {
      params = {'username': username, 'email': email, 'password': password};
    }

    request.fields.addAll(params);

    // request.files.add(
    //     await http.MultipartFile.fromPath('profileImage', '/path/to/file'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var updateData = await response.stream.bytesToString();
      var decodedData = jsonDecode(updateData);
      Fluttertoast.showToast(msg: decodedData['message']);
    } else {
      print(response.reasonPhrase);
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
