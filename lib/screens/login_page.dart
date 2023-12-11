import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/screens/registration_page.dart';
import 'package:todist/screens/bin/task_add_page.dart';

import '../Bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login successful'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskAddPage()),
                );
              }
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Image.asset('assert/Google.png'),
                            const Text(
                              'Login with Gmail',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(height: 1, width: 130, color: Colors.black),
                        const Text('OR'),
                        Container(height: 1, width: 130, color: Colors.black)
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Unlock Productivity with Task Pareto',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginButtonPressed(
                              email: emailController.text,
                              password: passwordController.text));
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegistrationPage()),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password!',
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
