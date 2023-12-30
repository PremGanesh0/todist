import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/login/login_bloc.dart';
import 'package:todist/api/get_user_details_api.dart';
import 'package:todist/api/registration_api.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> loginApi(LoginButtonPressed event, Emitter<LoginState> emit) async {
  emit(const LoginLoading());
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('${baseUrl}login'));
  request.body = json.encode({"email": event.email, "password": event.password, "type": 1});
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      User userdata = User.fromJson(data['data']['user']);
      getUserDetails(userId: userdata.id);
      saveUserData(userdata);
      saveAccessToken(data['data']['accessToken']);
      emit(LoginSuccess(user: userdata));
    } else if (response.statusCode == 500) {
      emit(const LoginFailure(error: 'Internal Server Error  Status code 500'));
    } else if (response.statusCode == 401) {
      emit(LoginFailure(error: response.reasonPhrase.toString()));
      // error: 'Too Many Login Attempts from this IP, Please try after 5 minutes'));
    } else {
      var error = await response.stream.bytesToString();
      var data = jsonDecode(error);
      emit(LoginFailure(error: data['message']));
    }
  } catch (e) {
    emit(LoginFailure(error: e.toString()));
  } finally {}
}
