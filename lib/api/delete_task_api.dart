import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/utils.dart';

Future<void> deleteTaskApi({required Task task}) async {
  try {
    var accessToken = await LocalStorage.getAccessToken();
    String apiUrl =
        'https://dev.taskpareto.com/api/task/deleteTaskById/${task.serverid}';
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'DELETE',
      Uri.parse(apiUrl),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print(data);
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
  }
}
