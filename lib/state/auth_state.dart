import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  String? _username;

  bool get isLoggedIn => _username != null;
  String get username => _username ?? '';

  void login(String username) {
    final normalizedUsername = username.trim();
    if (normalizedUsername.isEmpty) {
      throw ArgumentError.value(username, 'username', 'Must not be empty.');
    }

    _username = normalizedUsername;
    notifyListeners();
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}
