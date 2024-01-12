import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todist/utils.dart';

Future<void> UpdateTaskDate({required String id, required String newDate}) async {
  String apiUrl = '$baseUrl/task/updateTaskDate';

  var headers = {
    'Authorization': 'your_jwt_token_here', 
    'Content-Type': 'application/json',
  };

  try {
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "taskId": id,
      "newDate": newDate,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during task date update: $error');
  }
}
