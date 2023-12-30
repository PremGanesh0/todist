import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';

// Future<void> googleSignIn(
//   GoogleSignInButtonPressed event,
//   Emitter<RegistrationState> emit,
// ) async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn();
//     ;

//     if (googleSignInAccount == null) {
//       // Handle sign-in cancellation
//       emit(RegistrationFailure(
//           error: 'Google Sign-In canceled', username: '', email: ''));
//       return;
//     }

//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );

//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     final User? user = userCredential.user;

//     if (user != null) {
//       // Successfully signed in, you can now use user.idToken or user.accessToken
//       print('Google Sign-In successful: ${user.idToken}');
//       emit(RegistrationSuccess(
//           username: user.displayName ?? '', email: user.email ?? ''));
//     } else {
//       emit(RegistrationFailure(
//           error: 'Google Sign-In failed', username: '', email: ''));
//     }
//   } catch (error) {
//     emit(RegistrationFailure(
//         error: 'Error during Google Sign-In: $error', username: '', email: ''));
//   }
// }

GoogleSignIn _googleSignIn = GoogleSignIn();

// Future<void> googleSignIn(
//   GoogleSignInButtonPressed event,
//   Emitter<RegistrationState> emit,
// ) async {
//   try {
//     print('vjqgd');

//     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//     print('jykhkg');
//     if (googleSignInAccount != null) {
//       print('Signed in: ${googleSignInAccount.displayName}');
//     } else {
//       print('Sign-in canceled');
//     }

//     emit(RegistrationLoading(username: '', email: ''));
//   } catch (error) {
//     emit(RegistrationFailure(error: error.toString(), username: '', email: ''));
//   }
// }

Future<void> googleSignIn(
  GoogleSignInButtonPressed event,
  Emitter<RegistrationState> emit,
) async {
  try {
    // GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // Successfully signed in
      // print('Signed in: ${googleSignInAccount.displayName}');

      // Get the authentication details
      // GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;

      // Retrieve the Google Access Token
      // String? accessToken = googleSignInAuthentication.accessToken;
      // print('Access Token: $accessToken');

      // Now you can send the accessToken to your backend
      //  Send the accessToken to your backend API
    } else {
      // Handle the case where the user canceled the sign-in process
      // print('Sign-in canceled');
    }

    emit(const RegistrationLoading(username: '', email: '')); // Update state as needed

    // Perform Google Sign-In and update state accordingly
  } catch (error) {
    emit(RegistrationFailure(error: error.toString(), username: '', email: ''));
  }
}
