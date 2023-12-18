import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/Bloc/repo/local_storage.dart';

Future<void> verifyEmail(
    VerifyEmailButtonPressed event, Emitter<RegistrationState> emit) async {
  emit(VerifyEmailloading());
  String apiUrl = 'https://dev.taskpareto.com/api/verifyEmail';
  var accesstoken = await LocalStorage.getToken();
  try {
    var headers = {
      'Authorization': accesstoken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body =
        json.encode({"email": event.email, "otp": event.otp.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // var responseData = json.decode(response.stream.toString());
      // print(responseData);
      emit(RegistrationSuccess(
        username: event.email,
        email: event.email,
      ));
    } else {
      emit(VerifyEmailFailed());
      // print('Failed to verify email. Status code: ${response.statusCode}');
      // print('Response body: ${response}');
    }
  } catch (error) {
    // print('Error: $error');
  }
}
