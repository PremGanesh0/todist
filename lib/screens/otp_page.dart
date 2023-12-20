import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/screens/home_screen.dart';

class OtpPage extends StatefulWidget {
  final String email;

  OtpPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  late List<FocusNode> _focusNodes;

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());

    for (int i = 0; i < 5; i++) {
      _controllers[i].addListener(() {
        print(_controllers[i].text);
        if (_controllers[i].text.length == 1) {
          if (i < 5) {
            _focusNodes[i + 1].requestFocus();
          }
        } else if (_controllers[i].text.isEmpty) {
          if (i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
          if (state is VerifyEmailFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wrong OTP'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text('Verify OTP'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          height: 50,
                          width: 50,
                          'assert/Screenshot 2023-11-15 151801.png'),
                      Image.asset(
                          height: 40,
                          width: 100,
                          'assert/Screenshot 2023-11-23 113906.png')
                    ],
                  ),
                  SizedBox(height: 30),
                  const Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.green),
                  ),
                  Text(
                    'The verification Code has been send to the',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Email:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      Text(' ${widget.email}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.red))
                    ],
                  ), // Use 'state.email' to get the email from the state
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 40.0,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counter: Offstage(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // if (state is VerifyEmailLoading)
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        String finalOtp = '';
                        for (var i = 0; i < 6; i++) {
                          finalOtp += _controllers[i].text;
                        }
                        print(finalOtp);

                        context.read<RegistrationBloc>().add(
                              VerifyEmailButtonPressed(
                                email: widget.email,
                                otp: int.parse(finalOtp),
                              ),
                            );
                      },
                      child: const Text('Verify'),
                    ),
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
