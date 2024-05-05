import 'dart:async';

import 'package:poultry/model/user.dart';
import 'package:poultry/path_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';


// class GlobalConstants {
//   // Define your constants
//   // static String baseUrl = "http://192.168.1.73:8000";
//   // static String baseUrl = "http://127.0.0.1:8000";
//   static String baseUrl = "http://127.0.0.1:8000";
//
//   // static String baseUrl = "https://nepal-hotels.onrender.com";
//
//   // aws
//   // static String baseUrl = "http://3.108.194.157:8000";
//
//   static StreamController<bool> _loginStatusController = StreamController<bool>.broadcast();
//
//   // Shared preferences instance
//   static late SharedPreferences _prefs;
//
//   // Initialize sha xred preferences
//   static Future<void> initSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   // Save user to SharedPreferences
//   static void saveUser(User user) {
//     String userJson = jsonEncode(user.toJson());
//     _prefs.setString('user', userJson);
//     _loginStatusController.add(true); // Notify listeners about login status change
//   }
//
//   // Retrieve user from SharedPreferences
//   static User? getUser() {
//     String? userJson = _prefs.getString('user');
//     if (userJson != null) {
//       Map<String, dynamic> userMap = jsonDecode(userJson);
//       return User.fromJson(userMap);
//     }
//     return null;
//   }
//
//   // Remove user from SharedPreferences
//   static void removeUser() {
//     _prefs.remove('user');
//     _loginStatusController.add(false); // Notify listeners about login status change
//   }
//
//   // Getter for login status
//   static bool get isLoggedIn => getUser() != null;
//   static Stream<bool> get loginStatusStream => _loginStatusController.stream;
//
//
//   // Save Firebase token to SharedPreferences
//   static void saveFirebaseToken(String token) {
//     _prefs.setString('firebase_token', token);
//   }
//
//   // Retrieve Firebase token from SharedPreferences
//   static String? getFirebaseToken() {
//     return _prefs.getString('firebase_token');
//   }
// }

import 'dart:async';
import 'package:poultry/model/user.dart';
import 'package:poultry/path_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalConstants {
  static String baseUrl = "http://127.0.0.1:8000";
  static StreamController<bool> _loginStatusController =
  StreamController<bool>.broadcast();
  static late SharedPreferences _prefs;

  // Initialize shared preferences
  static Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveUser(User user) {
    String userJson = jsonEncode(user.toJson());
    _prefs.setString('user', userJson);
    _loginStatusController.add(true); // Notify listeners about login status change
  }

  static User? getUser() {
    String? userJson = _prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  static void removeUser() {
    _prefs.remove('user');
    _loginStatusController.add(false); // Notify listeners about login status change
  }

  static bool get isLoggedIn => getUser() != null;
  static Stream<bool> get loginStatusStream => _loginStatusController.stream;

  static void saveFirebaseToken(String token) {
    _prefs.setString('firebase_token', token);
  }

  static String? getFirebaseToken() {
    return _prefs.getString('firebase_token');
  }
}
