import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    String uri = 'https://dev.taskpareto.com/api/';
    on<RegistrationButtonPressed>(Register);
  }

  void Register(RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
    print('register called');
    emit(RegistrationInitial()); // Emit loading state
    const String apiUrl = 'https://dev.taskpareto.com/api/register'; // Replace with your
    try {
      emit(RegistrationLoading());
      // Create a Map containing the form data
      Map<String, String> formData = {
        'username': event.username,
        'email': event.email,
        'password': event.password,
        'type': '1'
      };
      print(event.username);
      print(event.password);
      print(event.email);
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      formData.forEach((key, value) {
        request.fields[key] = value;
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var decodedData = json.decode(utf8.decode(responseData));
        print('Response: $decodedData');
        emit(RegistrationSuccess());
      } else {
        throw Exception('Failed to register user');
      }
    } catch (error) {
      print('Error: $error');
      emit(RegistrationFailure(error: error.toString()));
    }
  }
}
