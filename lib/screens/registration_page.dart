import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class RegistrationForm extends StatelessWidget {
  RegistrationForm({super.key});
  final ImagePicker imagePicker = ImagePicker();
  // final _image = null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController profileImagePathController =
        TextEditingController();

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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(height: 50,width: 50,'assert/Screenshot 2023-11-15 151801.png'),
                //     Image.asset(height: 100,width: 100,'assert/Screenshot 2023-11-20 105857.png')
                //   ],
                // ),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        height: 1,
                        width: 130,
                        color: Colors.grey,
                      ),
                      const Text("  OR  "),
                      Container(
                        height: 1,
                        width: 130,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What should we call you?',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    // XFile? image = await imagePicker.pickImage(
                    //     source: ImageSource.gallery,
                    //     imageQuality: 50,
                    //     preferredCameraDevice: CameraDevice.front);
                    // setState(() {
                    //   _image = File(image!.path);
                    // });
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red[200]),
                      width: 200,
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
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
                          context.read<RegistrationBloc>().add(
                                RegistrationButtonPressed(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  profileImagePath:
                                      profileImagePathController.text,
                                ),
                              );
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
                          Navigator.push(
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
        );
      },
    );
  }
}
