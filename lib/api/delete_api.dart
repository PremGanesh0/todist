import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/model/user_model.dart';

Future<void> getUserDetails({required String userId}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/deleteAccount';

  try {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('$apiUrl?userId=$userId');

    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(response.body);

      Map<String, dynamic> data = json.decode(response.body);
      User username = User.fromJson(data['username']['user']);

    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during getUserDetails request: $error');
  }
}