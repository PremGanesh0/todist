import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/screens/bin/task_add_page.dart';

class OtpPage extends StatelessWidget {
  final String email;

  OtpPage({Key? key, required this.email}) : super(key: key);

 final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskAddPage()),
            );
          }
          if (state is VerifyEmailFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Wrong OTP'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Verify OTP'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Hello'),
                  Text(
                      'Email: ${state.email}'), // Use 'state.email' to get the email from the state
                  const SizedBox(height: 20),
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(labelText: 'Enter OTP'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  if (state is VerifyEmailloading)
                    ElevatedButton(
                      onPressed: () {
                        context.read<RegistrationBloc>().add(
                              VerifyEmailButtonPressed(
                                email: email,
                                otp: int.parse(otpController.text),
                              ),
                            );
                      },
                      child: const Text('Verify'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
