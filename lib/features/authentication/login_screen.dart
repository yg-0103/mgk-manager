import 'package:flutter/material.dart';
import 'package:mgk_manager/features/authentication/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MGK'),
      ),
      body: const LoginForm(),
    );
  }
}
