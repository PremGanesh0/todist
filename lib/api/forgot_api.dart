import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/utils.dart';

Future<void> forgotPassword({required String email}) async {
  String apiUrl = '$baseUrl/requestPasswordReset';

  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var decodedData = json.decode(data);
      Fluttertoast.showToast(
        msg: decodedData['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      // print(response.reasonPhrase);
    }
  } catch (error) {
    // print('Error during password reset request: $error');
  }
}
