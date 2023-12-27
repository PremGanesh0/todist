import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/model/user_model.dart';

Future<void> getUserDetails({required String userId}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/getUserDetails';
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
      
      print(data);
     } else {
      print(response.reasonPhrase);
    }

  
  } catch (error) {
    print('Error during getUserDetails request: $error');
  }
}
