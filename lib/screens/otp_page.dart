import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/screens/home_page.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is VerifyEmail && state.requireEmailVerification) {
            String username = state.username;
            String email = state.email;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Verify OTP'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello $username'),
                Text('Email: $email'),
                const SizedBox(height: 20),
                // Add OTP fields here
                const TextField(
                  decoration: InputDecoration(labelText: 'Enter OTP'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement OTP verification logic here
                  },
                  child: const Text('Verify'),
                ),
              ],
            ),
          ),
        ));
  }
}
