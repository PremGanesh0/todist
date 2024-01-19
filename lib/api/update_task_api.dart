import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';

Future<void> updateTaskApi({required Task task}) async {
  print('.................Task updated.................');

  try {
    var accessToken = await LocalStorage.getAccessToken();
    // print(accessToken);
    String apiUrl =
        'https://dev.taskpareto.com/api/task/updateTask/${task.serverid}';

    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json',
    };
    
    var body = {
      "title": task.title,
      "description": task.description,
      "date": DateFormat('yyyy-MM-dd').format(task.date).toString(),
      "priority": "priority1",
      "reminders": ["2023-09-25"],
      "labels": ["Label 1", "Label 2"],
      "category": "family",
      "isFavorite": false,
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(body),
    );

    // print(response.statusCode);
    if (response.statusCode == 200) {
      var data = await response.body;
      print(data);
      // print('.................Task updated................');
    } else {
      // print('jagan:-${response.statusCode}');
    }
  } catch (error) {
    // print('Error during task update: $error');
  }
}
