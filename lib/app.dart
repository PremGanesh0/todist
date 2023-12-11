import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/screens/welcome_screen.dart';
import 'package:todist/utils.dart';

import 'Bloc/login/login_bloc.dart';
import 'Bloc/registration/registration_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider.instance,
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => TaskRepository(context.read<DatabaseProvider>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskBloc(
              TaskRepository(context.read<DatabaseProvider>()),
            ),
          ),
          BlocProvider(
            create: (context) => RegistrationBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
        ],
        child: MaterialApp(
          builder: FToastBuilder(),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
