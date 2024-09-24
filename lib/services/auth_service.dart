// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb/presentation/screens/skeleton_screen.dart';
import 'package:quadb/provider/auth_provider.dart' as ap;

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> loginWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Provider.of<ap.AuthProvider>(context, listen: false).setLoading(true);
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SkeletonScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      
      print('Error: ${e.message}');
    } catch (e) {

      print('Error: $e');
    } finally {
      if (context.mounted) {
        Provider.of<ap.AuthProvider>(context, listen: false).setLoading(false);
      }
    }
  }
}
