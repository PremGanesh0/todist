import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';

Future<void> completeTaskApi({required Task task}) async {
  try {
    var accessToken = await LocalStorage.getAccessToken();
    String apiUrl =
        'https://dev.taskpareto.com/api/task/${task.serverid}/complete';
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('-----------${response.statusCode}--------------');
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print('-------------------create task api--------------');
      print('Task Id :-${task.id}');
      print('Title :- ${task.title}');
      print('Description :- ${task.description}');
      print('Priority :- ${task.priority}');
      print('Task Complete :- ${task.completed}');
      print('Reminder :- ${task.remember}');
      print(data);
      var data1 = json.decode(data);
      Fluttertoast.showToast(msg: data1['message']);
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
  }
}
