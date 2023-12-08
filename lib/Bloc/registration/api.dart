import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage.dart';

void registerApi(
    RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
  emit(RegistrationLoading()); // Emit loading state

  String apiUrl = 'https://dev.taskpareto.com/api/register';

  try {
    Map<String, dynamic> formData = {
      'username': event.username,
      'email': event.email,
      'password': event.password,
      'profileImage': event.profileImagePath,
      'type': '1'
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(formData),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 201) {
      var userData = decodedData['data']['user'];
      User userdata = User.fromJson(userData);
      savedata(userdata, decodedData['data']);
      emit(VerifyEmail());
    } else if (response.statusCode == 400) {
      // print(decodedData['message']);
      emit(RegistrationFailure(error: decodedData['message']));
    } else {
      emit(RegistrationFailure(error: decodedData['message']));
    }
  } catch (error) {
    // print('catch');

    emit(RegistrationFailure(error: error.toString()));
  }
}

savedata(User user, decodedData) async {
  // print("savedata function");
  await LocalStorage.saveUserData(user);
  await LocalStorage.saveTokens(decodedData['accessToken']);
}

void verifyEmail(
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
