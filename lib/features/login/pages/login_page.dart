import 'package:fake_store/features/login/bloc/login_bloc.dart';
import 'package:fake_store/features/login/bloc/login_state.dart';
import 'package:fake_store/features/login/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocBuilder(builder: (context, state) {
        if (state is LoginSuccess) {
          
        } else if (state is LoginEmailError) {
          return _buildBody(state.message, null, null, false);
        } else if (state is LoginPasswordError) {
          return _buildBody(null, state.message, null, false);
        } else if (state is LoginFailed) {
          return _buildBody(null, null, state.message, false);
        } else if (state is LoginLoading) {
          return _buildBody(null, null, null, true);
        } else {
          throw Exception('Unknown state');
        }
      }),
    );
  }

  Widget _buildBody(String? loginError, String? passwordError, String? error, bool isProgress) {
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginInputField(
                hint: 'Email',
                icon: Icons.email,
                error: loginError,
                isEnabled: true,
                isPassword: false),
            const SizedBox(
              height: 20,
            ),
            LoginInputField(
                hint: 'Password',
                icon: Icons.security,
                error: passwordError,
                isEnabled: true,
                isPassword: true),
            const SizedBox(
              height: 20,
            ),
            error == null
                ? const SizedBox()
                : Center(
                    child: Text(
                      error,
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
                child: isProgress ? const CircularProgressIndicator() : null,
              ),
            )
          ],
        )),
      ),
    );
  }
}
