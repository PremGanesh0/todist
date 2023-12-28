import 'package:flutter/material.dart';
import 'package:todist/api/forgot_api.dart';
import 'package:todist/screens/login_page.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});

  TextEditingController emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 30),
            const Text(
              'Forgot Your Password?',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const Text(
              'To reset your password,please enter \n    the email address of your Task',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            const Text(
              'pareto account',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 40,
              width: 320,
              child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                forgotPassword(email: emailController.text);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(320, 40)),
              child:
                  const Text('Submit', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),
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
    );
  }


  
}
