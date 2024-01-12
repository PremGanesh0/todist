import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/utils.dart';

Future<void> UpdateTask({required Task task}) async {
  String apiUrl = '$baseUrl/task/updateTask/${task.serverid}';

  var headers = {
    'Authorization':
        'your_jwt_token_her e',
    'Content-Type': 'application/json',
  };

  try {
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "title": task.title,
      "description": task.description,
      "date": DateFormat('yyyy-MM-dd').format(task.date).toString(),
      "priority": "priority1",
      "reminders": ["2023-09-25"],
      "labels": ["Label 1", "Label 2"],
      "category": "family",
      "isFavorite": false,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during task update: $error');
  }
}
