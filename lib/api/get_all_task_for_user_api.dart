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
    // print(
    // " get all api task type -------status code -------${response.statusCode}-------------------");
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var responseData = json.decode(data);
      // print('status ${responseData['status']}');
      // print('task ${responseData['tasks']}');
      List<Task> taskList = [];
      for (var taskJson in responseData['tasks']) {
        // print('---------------task-----${taskJson['date']}--------');
        // print(taskJson);
        // print('Task Id :-${taskJson['id']}');
        // print('Title :- ${taskJson['title']}');
        // print('Description :- ${taskJson['description']}');
        // print('Priority :- ${taskJson['priority']}');
        // print('Task Complete :- ${taskJson['completed']}');
        // print('Reminder :- ${taskJson['remember']}');
        // print('date ${taskJson['date']}');
        String dateString = taskJson['date'];
        DateTime dateTime = DateTime.parse(dateString);
        // print('date ${dateTime} runtime typw ${dateTime.runtimeType}');
        Task task = Task(
          serverid: taskJson['id'],
          title: taskJson['title'],
          description: taskJson['description'],
          date: dateTime,
          priority: taskJson['priority'],
          label: 'colors',
          remember: false,
          completed: taskJson['completed'],
        );
        taskList.add(task);
      }
      return taskList;
    } else {
      print('No tasks found in the response.');
      return [];
    }
  } catch (error) {
    print('Error during API request: $error');
    Fluttertoast.showToast(msg: error.toString());
    return [];
  }
}
