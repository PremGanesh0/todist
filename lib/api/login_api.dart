import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/login/login_bloc.dart';
import 'package:todist/api/registration_api.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> loginApi(
    LoginButtonPressed event, Emitter<LoginState> emit) async {
  emit(LoginLoading());
  var headers = {'Content-Type': 'application/json'};

  print(event.email);
  print(event.password);
  var request = http.Request('POST', Uri.parse('${baseUrl}login'));
  // request.body = json
  //     .encode({"email": event.email, "password": event.password, "type": 1});

  // request.body = json.encode({
  //   "email": 'swamysanthosh.k@krify.com',
  //   "password": 'Krify@123',
  //   "type": 1
  // });
  request.body = json
      .encode({"email": event.email, "password": event.password, "type": 1});
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      print(data);
      User userdata = User.fromJson(data['data']['user']);
      saveUserData(userdata);
      saveAccessToken(data['data']['accessToken']);
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
