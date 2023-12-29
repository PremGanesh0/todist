import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> deleteAccount({required String userId}) async {
  String apiUrl = '$baseUrl/refresh-token';
  var refreshToken = await LocalStorage.getToken();
  try {
    var headers = {
      'Authorization': refreshToken['refreshToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({"userId": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
  
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
    }
  } catch (error) {
    print(': $error');
  }
}
