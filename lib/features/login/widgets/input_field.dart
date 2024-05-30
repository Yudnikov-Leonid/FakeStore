import 'package:fake_store/features/login/bloc/login_bloc.dart';
import 'package:fake_store/features/login/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginInputField extends StatelessWidget {
  LoginInputField(
      {required this.hint,
      required this.icon,
      this.error,
      required this.isEnabled,
      required this.isPassword,
      super.key});

  final TextEditingController _controller = TextEditingController();

  final String hint;
  final IconData icon;
  final String? error;
  final bool isEnabled;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            errorText: error),
        obscureText: isPassword,
        readOnly: !isEnabled,
        onChanged: (value) {
          context.read<LoginBloc>().add(LoginHideErrorsEvent());
        },
      ),
    );
  }
}
