import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  bool _loading = false;
  bool get loading => _loading;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  AuthProvider() {
    checkSignInStatus();
  }

  Future<void> checkSignInStatus() async {
    _isSignedIn = _firebaseAuth.currentUser != null;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
