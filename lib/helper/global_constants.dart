import 'dart:async';

import 'package:path_provider/path_provider.dart';
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
  // static String baseUrl = "http://127.0.0.1:8000";
  // static String baseUrl = "http://192.168.1.73:8000";

  // Production
  static String baseUrl = "https://duwalpoultry.nepalnesthotels.com";


  static StreamController<bool> _loginStatusController =
  StreamController<bool>.broadcast();

  static StreamController<String> _languageController =
  StreamController<String>.broadcast();
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

  // Save selected language to SharedPreferences
  static void saveSelectedLanguage(String languageCode) {
    _prefs.setString('selected_language', languageCode);
    _languageController.add(languageCode); // Notify listeners about language change
  }

  static String getSelectedLanguage() {
    String? savedLanguage = _prefs.getString('selected_language');
    return savedLanguage ?? 'en'; // Return 'en' if nothing is saved
  }

  static void dispose() {
    _languageController.close();
  }
  // Listen for language changes
  static Stream<String> get languageChangeStream => _languageController.stream;



  // Retrieve image path from SharedPreferences
  static String? getImagePath() {
    print(_prefs.getString('profile_image'));
    return _prefs.getString('profile_image');
  }

  // Save image path to SharedPreferences
  static void saveImagePath(String imagePath) {
    _prefs.setString('profile_image', imagePath);
  }

  // Retrieve birthdate from SharedPreferences
  static String? getBirthdate() {
    return _prefs.getString('birthdate');
  }

  // Save birthdate to SharedPreferences
  static void saveBirthdate(String birthdate) {
    _prefs.setString('birthdate', birthdate);
  }



  // // Save image locally and return the path
  // static Future<String> saveImageLocally(File image) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   final fileName = 'profile_image_${DateTime.now().millisecondsSinceEpoch}.png';
  //   final imagePath = '$path/$fileName';
  //   final File localImage = await image.copy(imagePath);
  //   saveImagePath(localImage.path);
  //   return localImage.path;
  // }

  // Save image locally and return the path
  static Future<String> saveImageLocally(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName =
        'profile_image_${DateTime.now().millisecondsSinceEpoch}.png';
    final imagePath = '$path/$fileName';
    final File localImage = File(imagePath);

    // Save image file to the documents directory
    await image.saveTo(path);

    // Save the image path to SharedPreferences
    saveImagePath(imagePath);

    return imagePath;
  }


}
