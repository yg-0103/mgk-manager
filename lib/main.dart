import 'package:flutter/material.dart';
import 'package:mgk_manager/features/authentication/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mgk_manager/features/home/home_screen.dart';
import 'package:mgk_manager/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'MGK manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ref.watch(getIsAuthenticationProvider).when(
          data: (bool isAuthentication) =>
              isAuthentication ? HomeScreen() : const LoginScreen(),
          error: (error, stackTrace) => const LoginScreen(),
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
