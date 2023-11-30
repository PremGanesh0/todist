import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage.dart';
import 'package:todist/utils.dart';

import '../../screens/task_add_page.dart';

// void registerApi(
//     RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
//   emit(RegistrationLoading()); // Emit loading state
//   String apiUrl = '${BaseUrl}register';

//   try {
//     // Prepare the data to be sent in the request body
//     Map<String, dynamic> formData = {
//       'username': event.username,
//       'email': event.email,
//       'password': event.password,
//       'profileImage':
//           event.profileImagePath, // Assuming you want to send the path
//       'type': '1'
//     };
//     print(formData);
//     // Send a POST request
//     var response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'}, // Set content type to JSON
//       body: json.encode(formData), // Convert formData to a JSON string
//     );
//     var decodedData = json.decode(response.body);

//     if (response.statusCode == 201) {
//       emit(RegistrationSuccess());
//       // emit(VerifyEmail());
//       // verifyEmail(event.email, '3333');
//     } else if (response.statusCode == 200) {
//       throw Exception(response.body);
//     } else {
//       // throw Exception('Failed to register user');
//       print(decodedData['message']);
//       emit(RegistrationFailure(error: decodedData['message']));
//     }
//   } catch (error) {
//     print(error);
//     emit(RegistrationFailure(error: error.toString()));
//   }
// }

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

    if (response.statusCode == 201) {
      var decodedData = json.decode(response.body);
      var userData = decodedData['data']['user'];
      emit(RegistrationSuccess(
        username: userData['username'],
        email: userData['email'],
      ));
      // Call the verifyEmail function here
      //verifyEmail();
      LocalStorage.saveUserData(decodedData['user']);
      LocalStorage.saveTokens(
          decodedData['accessToken'], decodedData['refreshToken']);
    } else {
      var decodedData = json.decode(response.body);
      print(decodedData['message']);
      emit(RegistrationFailure(error: decodedData['message']));
    }
  } catch (error) {
    emit(RegistrationFailure(error: error.toString()));
  }
}

Future<void> verifyEmail(String email, String otp) async {
  String apiUrl = '${BaseUrl}verifyEmail';

  try {
    // Prepare the data to be sent in the request body
    Map<String, dynamic> requestBody = {
      'email': email,
      'otp': otp,
    };

    // Send a POST request to the verifyEmail endpoint
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      // Email verification successful
      var responseData = json.decode(response.body);
      bool success = responseData['data']['success'];

      if (success) {
        print('Email verified successfully');
        
        // Perform any further actions here after successful verification
      } else {
        // Handle cases where email verification was not successful
        print('Email verification failed');
      }
    } else {
      // Handle cases where the HTTP request was not successful
      throw Exception('Failed to verify email');
    }
  } catch (error) {
    // Handle any errors that occurred during the process
    print('Error: $error');
    // You might want to emit an event or show an error message to the user
  }
}
