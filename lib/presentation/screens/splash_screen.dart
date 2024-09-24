// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quadb/presentation/screens/auth_screen.dart';
import 'package:quadb/presentation/screens/home_screen.dart';
import 'package:quadb/provider/auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (authProvider.isSignedIn) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AuthScreen()),
            );
          }
        });

        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: LottieBuilder.asset(
              "assets/Lottie/Animation 1727215575693.json",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        );
      },
    );
  }
}
