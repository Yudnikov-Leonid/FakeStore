import 'package:fake_store/features/login/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake store'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login to your account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginInputField(
                hint: 'Email',
                icon: Icons.email,
                isEnabled: true,
                isPassword: false),
            const SizedBox(
              height: 20,
            ),
            LoginInputField(
                hint: 'Password',
                icon: Icons.security,
                isEnabled: true,
                isPassword: true),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'some error',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(200, 50)),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        )),
      ),
    );
  }
}
