import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/model/user_model.dart';

Future<void> getUserDetails({required String userId}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/getUserDetails';
  var accessToken = await LocalStorage.getToken();
  print(accessToken.toString());
  try {
    var headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNmYmQ2NWJlLWEzYmEtMTFlZS04NjZiLTk3NjA2ZGUyNmFjMCIsImVtYWlsIjoibmFkb3RpNjE1OTFAdXNvcGxheS5jb20iLCJpYXQiOjE3MDM1ODg5MTYsImV4cCI6MTcwMzYxNzcxNn0.qHED5o6AqvBC0-0YW4xOGH6QYH5T36XBHgdf4dCxdQA',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse('https://dev.taskpareto.com/api/getUserDetails'));
    request.body =
        json.encode({"userId": "cfbd65be-a3ba-11ee-866b-97606de26ac0"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (responseBody.isNotEmpty) {
        var data = json.decode(responseBody);
        User userData = User.fromJson(data['data']);
      } else {
        print('Response body is empty');
      }
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during getUserDetails request: $error');
  }
}

