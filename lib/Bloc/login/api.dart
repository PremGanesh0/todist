import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/login/login_bloc.dart';
import 'package:todist/utils.dart';

Future<void> loginApi(
    LoginButtonPressed event, Emitter<LoginState> emit) async {
  emit(LoginLoading());

  var headers = {'Content-Type': 'application/json'};

  var request = http.Request('POST', Uri.parse('${BaseUrl}login'));
  // request.body = json.encode({"email": event.email, "password": event.password, "type": 1});

  request.body = json.encode(
      {"email": 'afzal.sk@krify.com', "password": 'Krify@123', "type": 1});

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      emit(LoginSuccess());
    } else {
      var error = await response.stream.bytesToString();
      var data = jsonDecode(error);

      emit(LoginFailure(error: data['message']));
    }
  } catch (e) {
    emit(LoginFailure(error: e.toString()));
  }
}
