import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> getUserDetails({required String userId}) async {
  String apiUrl = '$baseUrl/getUserDetails';
  var accessToken = await LocalStorage.getToken();
  print('access token form the localstorage ${accessToken.toString()}');
  print(userId);

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
      print(decodeData);
      User(
              id: userId,
              username: decodeData['data']['username'],
              email: decodeData['data']['email'],
              profileImage: decodeData['data']['profileImage'])
          .copyWith();
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during getUserDetails request: $error');
  }
}
