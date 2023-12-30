import 'package:flutter/material.dart';
import 'package:todist/Bloc/login/login_bloc.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/screens/profile_screen.dart';
import 'package:todist/screens/welcome_screen.dart';

PopupMenuButton<String> popupMenuButtonCustom(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (value) async {
      if (value == 'profile') {
        User userData = await LocalStorage.getUserData();

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    user: userData,
                  )),
        );
      } else if (value == 'logout') {
        await LocalStorage.clearUserData();
        LoginBloc loginBloc = LoginBloc();
        loginBloc.add(LogoutButtonPressed());
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      }
    },
    itemBuilder: (BuildContext context) => [
      const PopupMenuItem(
        value: 'profile',
        child: Text('Profile'),
      ),
      const PopupMenuItem(
        value: 'logout',
        child: Text('Logout'),
      ),
    ],
    icon: const Icon(
      Icons.menu,
      color: Colors.blue,
    ),
  );
}
