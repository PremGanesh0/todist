import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationButtonPressed>(registerFunction);
  }

  void registerFunction(RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading()); // Emit loading state
    const String apiUrl = 'https://dev.taskpareto.com/api/register';

    try {
      // Prepare the data to be sent in the request body
      Map<String, dynamic> formData = {
        'username': event.username,
        'email': event.email,
        'password': event.password,
        'profileImage': event.profileImagePath, // Assuming you want to send the path
        'type': '1'
      };

      // Send a POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, // Set content type to JSON
        body: json.encode(formData), // Convert formData to a JSON string
      );


      if (response.statusCode == 201) {
        // var decodedData = json.decode(response.body);
 
        emit(RegistrationSuccess());
      } else {
        throw Exception('Failed to register user');
      }
    } catch (error) {

      emit(RegistrationFailure(error: error.toString()));
    }
  }
}
