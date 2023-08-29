import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mgk_manager/features/authentication/view_models/signin_view_model.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var isSubmitting = false;
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        var state = ref.read(signInForm.notifier).state;
        ref.read(signInForm.notifier).state = {
          ...state,
          "password": _passwordController.text,
        };
      });
    });
    _emailController.addListener(() {
      setState(() {
        var state = ref.read(signInForm.notifier).state;
        ref.read(signInForm.notifier).state = {
          ...state,
          "email": _emailController.text,
        };
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    setState(() {
      isSubmitting = true;
    });
    await ref.read(signInProvider.notifier).signIn();

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '이메일',
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            '비밀번호',
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          MaterialButton(
            onPressed: isSubmitting ? null : onSubmit,
            child: FractionallySizedBox(
              widthFactor: 1.1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                    color: isSubmitting ? Colors.grey.shade100 : Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  '로그인',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
