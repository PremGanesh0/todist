import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';
 
Future<List<Task>> getalltaskapi() async {
  try {
    var accessToken = await LocalStorage.getAccessToken();
    String apiUrl = 'https://dev.taskpareto.com/api/task/getAllTasksForUser';
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'POST',
      Uri.parse(apiUrl),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(
        "api task type --------------${response.statusCode}-------------------");

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      var responseData = json.decode(data);

      if (responseData['status'] == 1) {
        if (responseData['tasks'] != null) {
          List<Task> taskList = [];

          for (var taskJson in responseData['tasks']) {
            Task task = Task(
              serverid: taskJson['id'],
              title: taskJson['title'],
              description: taskJson['description'],
              date: DateTime.now(),
              priority: taskJson['priority'],
              label: taskJson['label'],
              remember: taskJson['remember'] == 1,
              completed: taskJson['completed'] == 0,
            );
            taskList.add(task);
          }

          print(taskList);

          return taskList;
        } else {
          print('No tasks found in the response.');
          return [];
        }
      } else {
        print('API returned an error: ${responseData['message']}');
        return [];
      }
    } else {
      print('API request failed: ${response.reasonPhrase}');
      return [];
    }
  } catch (error) {
    print('Error during API request: $error');
    Fluttertoast.showToast(msg: error.toString());
    return [];
  }
}
