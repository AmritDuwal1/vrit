import 'dart:async';

class AuthService {
  static StreamController<bool> _loginStatusController = StreamController<bool>.broadcast();

  static Stream<bool> get loginStatusStream => _loginStatusController.stream;

  static void login() {
    // Your login logic here
    _loginStatusController.add(true);
  }

  static void logout() {
    // Your logout logic here
    _loginStatusController.add(false);
  }

  static void dispose() {
    _loginStatusController.close();
  }
}
