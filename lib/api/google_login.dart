import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> googleSignIn(
  GoogleSignInButtonPressed event,
  Emitter<RegistrationState> emit,
) async {
  print('called google g');
  try {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    print('try ');
    if (googleSignInAccount != null) {
      // Successfully signed in
      print('Signed in: ${googleSignInAccount.displayName}');

      // Get the authentication details
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Retrieve the Google Access Token
      String? accessToken = googleSignInAuthentication.accessToken;
      print('Access Token: $accessToken');

      // Now you can send the accessToken to your backend
      //  Send the accessToken to your backend API
    } else {
      // Handle the case where the user canceled the sign-in process
      // print('Sign-in canceled');
    }

    emit(const RegistrationLoading(
        username: '', email: '')); // Update state as needed

    // Perform Google Sign-In and update state accordingly
  } catch (error) {
    emit(RegistrationFailure(error: error.toString(), username: '', email: ''));
  }
}
