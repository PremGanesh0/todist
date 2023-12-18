import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/utils.dart';

Future<void>  registerApi(
    RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
  emit(RegistrationLoading()); 
  String apiUrl = '${baseUrl}/register';

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
    print(decodedData);

    if (response.statusCode == 201) {
      var userData = decodedData['data']['user'];
      User userdata = User.fromJson(userData);
      saveUserData(
        userdata,
      );
      saveAccessToken(decodedData['data']['accessToken']);
      emit(VerifyEmail());
    } else if (response.statusCode == 400) {
      print(decodedData['message']);
      emit(RegistrationFailure(error: decodedData['message']));
    } else {
      emit(RegistrationFailure(error: decodedData['message']));
    }
  } catch (error) {
    print('catch');

    emit(RegistrationFailure(error: error.toString()));
  }
}

saveUserData(
  User user,
) async {
   await LocalStorage.saveUserData(user);
}

saveAccessToken(String accessToken) async {
  await LocalStorage.saveTokens(accessToken);
}


