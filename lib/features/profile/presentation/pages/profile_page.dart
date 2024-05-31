import 'package:fake_store/features/login/preentation/bloc/login_bloc.dart';
import 'package:fake_store/features/login/preentation/bloc/login_event.dart';
import 'package:fake_store/features/navigator/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(
                Icons.person,
                size: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      FirebaseAuth.instance.currentUser!.email!),
                  TextButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginLogOutEvent());
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                StoreNavigatorState.of(context)?.moveTo(1);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade50,
                child: const Text('Favorites'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                StoreNavigatorState.of(context)?.moveTo(2);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade50,
                child: const Text('Cart'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade50,
                child: const Text('History'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
