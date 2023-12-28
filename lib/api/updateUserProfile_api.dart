import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/utils.dart';

Future<void> updateUserProfile({
  required String username,
  required String email,
  required String password,
  required String profileImage,
}) async {
  String apiUrl = '$baseUrl/updateUserProfile';

  try {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(apiUrl);

    // Use http.put for updating data
    http.Response response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'profileImage': profileImage,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      );
    } else {
      print('Request failed: ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Error during updateUserProfile request: $error');
  }
}

