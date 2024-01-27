import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> updateUserProfileApi({
  required String username,
  required String email,
  required String profileImage,
}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/updateUserProfile';
  print('apiUrl: $apiUrl');
  // try {
  //   var accessToken = await LocalStorage.getAccessToken();
  //   print('  ${accessToken['accessToken'].toString()}');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     // 'Authorization': ' ${accessToken['accessToken'].toString()}',
  //     'Authorization':
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg0NzE1Y2E4LWJiNDUtMTFlZS04NjZiLTk3NjA2ZGUyNmFjMCIsImVtYWlsIjoiYmV2YXZldzUzNUB0c2RlcnAuY29tIiwiaWF0IjoxNzA2MTYyMDI1LCJleHAiOjE3MDYxOTA4MjV9.S8rFodQjK59dwE3921ATRgYFvHmbHMIpIyOLVpKC5XA'
  //   };
  //   var url = Uri.parse(apiUrl);

  //   http.Response response = await http.put(
  //     url,
  //     headers: headers,
  //     body: json.encode({
  //       'username': username,
  //       'email': email,
  //       'profileImage': profileImage,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('if response.body:${response.statusCode} ${response.body}');

  //     Fluttertoast.showToast(
  //       msg: response.body,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP,
  //     );
  //   } else {
  //     print(' else response.body:${response.statusCode} ${response.body}');
  //     Fluttertoast.showToast(
  //       msg: response.body,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP,
  //     );
  //   }
  // }
  var accessToken = await LocalStorage.getAccessToken();
  var headers = {'Authorization': accessToken['accessToken'].toString()};
  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields.addAll(
        {'username': username, 'email': email, 'password': 'Krify@123'});
    // request.files.add(
    //     await http.MultipartFile.fromPath('profileImage', '/path/to/file'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('error: $error');
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }
}
