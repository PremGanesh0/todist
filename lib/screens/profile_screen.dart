import 'package:flutter/material.dart';
import 'package:todist/api/deleteAccount_api.dart';
import 'package:todist/model/user_model.dart';
import 'package:todist/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print('inside profile page ${widget.user.profileImage}');
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
              // CircleAvatar(
              //   radius: 50.0,
              //   backgroundImage: NetworkImage(widget.user.profileImage),
              //   backgroundColor: Colors.transparent,
              // ),

              Stack(
                children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned.fill(
                    child: ClipOval(
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            'assert/progilr image.webp'), // Placeholder image
                        image: NetworkImage(widget.user.profileImage),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'assert/progilr image.webp'); // Placeholder for error
                        },
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                        fadeInDuration: Duration(milliseconds: 300),
                        fadeOutDuration: Duration(milliseconds: 100),
                        // You can customize the placeholder, errorWidget, and other parameters as needed
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Username :- '),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email :- '),
                    SizedBox(
                      height: 40,
                      width: 250,
                      child: TextField(
                        readOnly: true,
                        controller: emailController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text('Password: '),
              //       SizedBox(
              //         height: 40,
              //         width: 250,
              //         child: TextField(
              //           controller: passwordController,
              //           obscureText: true,
              //           decoration:
              //               const InputDecoration(border: OutlineInputBorder()),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //  updateUserProfile(
                  //    username: usernameController.text,
                  //   email: emailController.text,
                  //    password: passwordController.text,
                  //    // Add the profileImage parameter if needed
                  //  );
                },
                child: const Text('Edit'),
              ),
              SizedBox(
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
                    deleteAccount(userId: widget.user.id);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()));
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
