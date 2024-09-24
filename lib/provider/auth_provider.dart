import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // loading state
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
