import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';

Future<void> getalltaskapi() async {
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

// Future<List<Task>> getalltaskapi() async {
//   try {
//     var accessToken = await LocalStorage.getAccessToken();
//     String apiUrl = 'https://dev.taskpareto.com/api/task/getAllTasksForUser';
//     var headers = {
//       'Authorization': accessToken['accessToken'].toString(),
//       'Content-Type': 'application/json',
//     };

//     var response = await http.get(
//       Uri.parse(apiUrl),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       List<Task> apiTasks =
//           List<Task>.from(data.map((taskJson) => Task.fromJson(taskJson)));
//       return apiTasks;
//     } else {
//       print('API request failed: ${response.reasonPhrase}');
//       return [];
//     }
//   } catch (error) {
//     print('Error during API request: $error');
//     Fluttertoast.showToast(msg: error.toString());
//     return [];
//   }
// }
