import 'package:flutter/material.dart';
import 'package:todist/screens/login_page.dart';
import 'package:todist/screens/registration_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Task Pareto')),
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
                    height: 100,
                    width: 100,
                    'assert/Screenshot 2023-11-23 113906.png')
              ],
            ),
            Image.asset(
                height: 250,
                width: 250,
                'assert/Screenshot 2023-11-15 164716.png'),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Super Charge Your Productivity with Task Pareto',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text('Log in')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: const Text('Register')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
