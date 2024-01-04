import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> registerApi(
    RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
  emit(RegistrationLoading(username: event.username, email: event.email));
  String apiUrl = '$baseUrl/register';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields.addAll({
      'username': event.username,
      'email': event.email,
      'password': event.password,
      'type': '1',
    });
    if (event.profileImagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'profileImage', event.profileImagePath));
    }
    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    var decodedData = json.decode(data);
    if (response.statusCode == 201) {
      var userData = decodedData['data']['user'];
      User userdata = User.fromJson(userData);
      saveUserData(userdata);
      saveAccessToken(decodedData['data']['accessToken']);
      emit(VerifyEmail(username: event.username, email: event.email));
    } else if (response.statusCode == 400) {
      emit(RegistrationFailure(
          email: event.email,
          username: event.username,
          error: decodedData['message']));
    } else if (response.statusCode == 500) {
      emit(RegistrationFailure(
          email: event.email,
          username: event.username,
          error: 'Internal Sever Error 500'));
    } else {
      emit(RegistrationFailure(
          email: event.email,
          username: event.username,
          error: decodedData['message']));
    }
  } catch (error) {
    emit(RegistrationFailure(
        error: error.toString(), username: event.username, email: event.email));
  }
}

saveUserData(User user) async {
  await LocalStorage.saveUserData(user);
}

saveAccessToken(String accessToken) async {
  await LocalStorage.saveAccessTokens(accessToken);
}

saveRefreshToken(String refreshToken) async {
  await LocalStorage.saveRefreshToken(refreshToken);
}
