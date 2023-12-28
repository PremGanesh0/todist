import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> deleteAccount({required String userId}) async {
  String apiUrl = '$baseUrl/deleteAccount';
  var accessToken = await LocalStorage.getToken();
  try {
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(apiUrl));
    request.body = json.encode({"userId": userId});
    request.headers.addAll(headers);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var decodeData = jsonDecode(data);

      print(data);

      Fluttertoast.showToast(
        msg: decodeData['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during delete account: $error');
  }
}
