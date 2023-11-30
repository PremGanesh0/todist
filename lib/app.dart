import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/screens/home_page.dart';
import 'package:todist/screens/task_add_page.dart';
import 'Bloc/login/login_bloc.dart';
import 'Bloc/registration/registration_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
