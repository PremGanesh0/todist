import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/api/get_user_details_api.dart';
import 'package:todist/api/update_user_profile_api.dart';
import 'package:todist/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  dynamic _image;
  @override
  void initState() {
    super.initState();
    getuserdetails();
  }

  getuserdetails() async {
    getUserDetails(userId: widget.user.id);
    User user = await LocalStorage.getUserData();
    usernameController.text = user.username;
    emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  InkWell( 
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );

                      if (image != null) {
                        setState(() {
                          _image = File(image.path);
                        });
                      } else {}
                    },
                    child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: _image != null
                            ? FileImage(_image!) // Assuming _image is a File
                            : null, // Set to null if _image is null
                        child: _image),
                  ),
                  Positioned.fill(
                    child: ClipOval( 
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assert/progilr image.webp'),
                        image: NetworkImage(widget.user.profileImage),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assert/progilr image.webp');
                        },
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                        fadeInDuration: const Duration(milliseconds: 300),
                        fadeOutDuration: const Duration(milliseconds: 100),
                        placeholderErrorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 55),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                      width: 250,
                      child: TextField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 55),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 250,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextField(
                          readOnly: true,
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 55),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Change Password')),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            updateUserProfileApi(
                              username: usernameController.text,
                              email: emailController.text,
                              profileImage: widget.user.profileImage,
                            );
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                              'Are you sure you want to delete your account?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Delete My Account',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
