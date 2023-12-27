import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> forgotPassword({required String email}) async {
  String apiUrl = 'https://dev.taskpareto.com/api/requestPasswordReset';

  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error during password reset request: $error');
  }
}
