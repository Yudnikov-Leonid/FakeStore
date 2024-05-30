import 'package:fake_store/features/login/preentation/bloc/login_bloc.dart';
import 'package:fake_store/features/login/preentation/bloc/login_event.dart';
import 'package:fake_store/features/login/preentation/bloc/login_state.dart';
import 'package:fake_store/features/login/preentation/widgets/input_field.dart';
import 'package:fake_store/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => sl(),
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginSuccess) {
          return const Text('success');
        } else if (state is LoginInitial) {
          return _buildBody(context, null, null, null, false);
        } else if (state is LoginEmailError) {
          return _buildBody(context, state.message, null, null, false);
        } else if (state is LoginPasswordError) {
          return _buildBody(context, null, state.message, null, false);
        } else if (state is LoginFailed) {
          return _buildBody(context, null, null, state.message, false);
        } else if (state is LoginLoading) {
          return _buildBody(context, null, null, null, true);
        } else {
          throw Exception('Unknown state: $state');
        }
      }),
    );
  }

  Widget _buildBody(BuildContext context, String? loginError,
      String? passwordError, String? error, bool isProgress) {
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
                controller: _loginController,
                hint: 'Email',
                icon: Icons.email,
                error: loginError,
                isEnabled: true,
                isPassword: false),
            const SizedBox(
              height: 20,
            ),
            LoginInputField(
                controller: _passwordController,
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
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    final bloc = context.read<LoginBloc>();
                    bloc.add(LoginLoginEvent(
                        _loginController.text, _passwordController.text));
                  },
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
