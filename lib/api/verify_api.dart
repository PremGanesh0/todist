import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/api/get_user_details_api.dart';
import 'package:todist/api/registration_api.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/utils.dart';

Future<void> verifyEmailApi(
    VerifyEmailButtonPressed event, Emitter<RegistrationState> emit) async {
  String apiUrl = '$baseUrl/verifyEmail';
  var accesstoken = await LocalStorage.getAccessToken();
  print('otp${event.otp.toString()}');
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
    print(response.statusCode);
    String responseBody = await response.stream.bytesToString();
    var data = jsonDecode(responseBody);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(data);
      // User userdata = User.fromJson(data['data']['user']);
      // getUserDetails(userId: userdata.id);
      // saveUserData(userdata);
      // saveAccessToken(data['data']['accessToken']);
      // saveRefreshToken(data['data']['refreshToken']);
      emit(RegistrationSuccess(
        username: event.email,
        email: event.email,
      ));
    } else {
      Fluttertoast.showToast(
          msg: data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  } catch (error) {
    emit(VerifyEmailFailed(error: error.toString()));
  }
}
