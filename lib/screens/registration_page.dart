import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todist/screens/login_page.dart';
import 'package:todist/screens/otp_page.dart';
import '../Bloc/registration/registration_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: BlocProvider(
        create: (context) => RegistrationBloc(),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformpasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  bool passwordObscureText = true;
  bool conformPasswordObscureText = true;

  bool _isPasswordMatch(String confirmPassword) {
    return confirmPassword == passwordController.text;
  }

  var _image = null;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is VerifyEmail) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(email: state.email)),
          );
        } else if (state is RegistrationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${state.error}'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const Text(
                    'Unlock Productivity with Task Pareto',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<RegistrationBloc>().add(
                                GoogleSignInButtonPressed(),
                              );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assert/Google.png'),
                            const Text(
                              " Login with Gmail Account",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff9098B1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 130,
                          color: Colors.grey,
                        ),
                        const Text("OR"),
                        Container(
                          height: 1,
                          width: 130,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        final imagePicker = ImagePicker();
                        XFile? image = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                          // preferredCameraDevice: CameraDevice.front, // Check if your package version supports this
                        );

                        if (image != null) {
                          setState(() {
                            _image = File(image.path);
                            print("image path ${_image}");
                          });
                        } else {
                          // Handle the case where the user canceled image selection.
                          print('Image selection canceled');
                        }
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: _image != null
                            ? FileImage(_image!) // Assuming _image is a File
                            : null, // Set to null if _image is null
                        child: _image == null
                            ? Icon(
                                Icons.collections,
                                color: Colors.grey[800],
                              )
                            : null, // Set to null if you don't want to display anything on top of the image
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What should we call you?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      //  labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        print('email is empty');
                        return ('Please enter valied  email id');
                      }
                      // You can add more complex email validation logic here
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscuringCharacter: '*',
                    obscureText: passwordObscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(passwordObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordObscureText = !passwordObscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: conformpasswordController,
                    obscuringCharacter: '*',
                    obscureText: conformPasswordObscureText,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(conformPasswordObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            conformPasswordObscureText =
                                !conformPasswordObscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      if (!_isPasswordMatch(value)) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocConsumer<RegistrationBloc, RegistrationState>(
                    listener: (context, state) {
                      // Handle success or failure states if needed
                    },
                    builder: (context, state) {
                      if (state is RegistrationLoading) {
                        // Show loading indicator
                        return const CircularProgressIndicator();
                      } else {
                        // Your existing UI code
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_image == null) {
                                Fluttertoast.showToast(
                                    msg: 'Please Select the Profile');
                              } else {
                                context.read<RegistrationBloc>().add(
                                      RegistrationButtonPressed(
                                        username: usernameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        profileImagePath: _image.path,
                                      ),
                                    );
                              }
                            }
                          },
                          child: const Text('Register'),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already signed up?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            'Go to login',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
