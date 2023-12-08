import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/screens/welcome_screen.dart';
import 'package:todist/utils.dart';
import 'Bloc/login/login_bloc.dart';
import 'Bloc/registration/registration_bloc.dart';

/// This is secound entry point where we define the theme data provider repository providers all there
/// to main the application [MyApp] [lightTheme] this is user for the light theme of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DatabaseProvider>(
              create: (context) => DatabaseProvider.instance,
            ),
            RepositoryProvider<TaskRepository>(
                create: (context) =>
                    TaskRepository(context.read<DatabaseProvider>())),
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
            // child: BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (context, state) {
            //     // Use state to dynamically switch between light and dark themes
            //     return const HomePage();
            //   },
            // ),
            child: const WelcomeScreen(),
          ),
        ));
  }
}
