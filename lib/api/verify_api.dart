import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/utils.dart';

Future<void> verifyEmail(VerifyEmailButtonPressed event, Emitter<RegistrationState> emit) async {
  String apiUrl = '$baseUrl/verifyEmail';
  var accesstoken = await LocalStorage.getAccessToken();
  try {
    var headers = {
      'Authorization': accesstoken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({"email": event.email, "otp": event.otp.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseData = json.decode(response.stream.toString());
      Fluttertoast.showToast(
          msg: responseData['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      emit(RegistrationSuccess(
        username: event.email,
        email: event.email,
      ));
    } else {
      emit(VerifyEmailFailed(error: response.reasonPhrase.toString()));
    }
  } catch (error) {
    emit(VerifyEmailFailed(error: error.toString()));
  }
}
