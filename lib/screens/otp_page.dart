import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/registration/registration_bloc.dart';
import 'package:todist/screens/home_screen.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({Key? key, required this.email}) : super(key: key);

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
    _focusNodes = List<FocusNode>.generate(6, (_) => FocusNode());
    _controllers =
        List<TextEditingController>.generate(6, (_) => TextEditingController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupFocusNodesAndControllers();
    });
  }

  void _setupFocusNodesAndControllers() {
    for (var i = 0; i < 6; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _controllers[i].clear();
        }
      });
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty) {
          if (i < 5) {
            _focusNodes[i + 1].requestFocus();
          } else {
            _focusNodes[i].unfocus();
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
            Fluttertoast.showToast(
                msg: "Email verified successfully ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
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
                  const SizedBox(height: 30),
                  const Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.green),
                  ),
                  const Text(
                    'The verification Code has been send to the',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Email:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      Text(' ${widget.email}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.red))
                    ],
                  ),
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
                          decoration: const InputDecoration(
                            counter: Offstage(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        String finalOtp = '';
                        for (var i = 0; i < 6; i++) {
                          finalOtp += _controllers[i].text;
                        }
                        // print(finalOtp);

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
