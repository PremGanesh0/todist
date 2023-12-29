import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/screens/home_screen.dart';
import 'package:todist/screens/welcome_screen.dart';
import 'package:todist/utils.dart';

import 'Bloc/login/login_bloc.dart';
import 'Bloc/registration/registration_bloc.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    User user = await LocalStorage.getUserData();
    setState(() {
      isLoggedIn = user.id.isNotEmpty;
    });
    print(
        'user details ${user.email}   ${user.id} ${user.username}  ${user.profileImage}');
    print('is logedin $isLoggedIn');
  }

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
          home: isLoggedIn ? const WelcomeScreen() : const HomeScreen(),
        ),
      ),
    );
  }
}
