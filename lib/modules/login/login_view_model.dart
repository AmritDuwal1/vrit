import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poultry/api/user_api.dart';


import 'package:poultry/path_collection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends ChangeNotifier {
  final UserAPI userApi = UserAPI();
  bool isLoading = false;
  late User user;
  bool _isLoggedIn = false;
// Getter for isLoggedIn property
  bool get isLoggedIn => _isLoggedIn;
  Result? result;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void login(String username, String password) {
    isLoading = true;
    notifyListeners();
    userApi.loginUser(username, password, (user) {
      // Handle success
      print('Login successful: ${user.token}');
      isLoading = false;
      _isLoggedIn = true;
      saveUser(user);
      GlobalConstants.saveUser(user);
      print(GlobalConstants.getUser());
      result = Result.success(message: 'Login Successful');
      notifyListeners();
    }, (error) {
      // Handle failure
      print('Error logging in: $error');
      isLoading = false;
      _isLoggedIn = false;
      result = Result.error(error.message);
      notifyListeners();
    });
  }

  // Future<void> loginWithGoogle() async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       throw Exception('Google Sign In cancelled by user.');
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final String idToken = googleAuth.idToken ?? '';
  //
  //     //
  //     final User loggedInUser = await userApi.loginWithGoogle(idToken);
  //
  //     print('Logged in with Google: ${loggedInUser.token}');
  //     isLoading = false;
  //     _isLoggedIn = true;
  //     // saveUser(loggedInUser);
  //     result = Result.success(message: 'Login Successful');
  //   } catch (error) {
  //     print('Error logging in with Google: $error');
  //     isLoading = false;
  //     _isLoggedIn = false;
  //     result = Result.error(error.toString());
  //   }
  //
  //   notifyListeners();
  // }

  Future<void> loginWithGoogle() async {
    isLoading = true;
    notifyListeners();
    result = null;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign In cancelled by user.');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String idToken = googleAuth.idToken ?? '';


      // Access user's profile information
      final String firstName = googleUser.displayName?.split(' ')[0] ?? '';
      final String lastName = googleUser.displayName?.split(' ')[1] ?? '';
      final String username = googleUser.email?.split('@')[0] ?? '';
      final String? profileImageUrl = googleUser.photoUrl;

      print('Logged in with Google:');
      print('Token: $idToken');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Username: $username');
      print('Profile Image URL: $profileImageUrl');

      Future.delayed(Duration(seconds: 0), () {
        socialLogin(idToken, true, null);
      });

    } catch (error) {
      print('Error logging in with Google: $error');
      isLoading = false;
      _isLoggedIn = false;
      result = Result.error(error.toString());
    }

    notifyListeners();
  }



  void socialLogin(String token, bool isGoogleLogin, AuthorizationCredentialAppleID? credential) {
    isLoading = true;
    notifyListeners();
    userApi.loginWithGoogle(token, isGoogleLogin, credential, (user) {
      // Handle success
      print('Login successful: ${user.token}');
      isLoading = false;
      _isLoggedIn = true;

      saveUser(user);
      GlobalConstants.saveUser(user);
      print(GlobalConstants.getUser());
      result = Result.success(message: 'Login Successful');
      notifyListeners();
    }, (error) {
      // Handle failure
      print('Error logging in: $error');
      isLoading = false;
      _isLoggedIn = false;
      result = Result.error(error.message);
      notifyListeners();
    });
  }



  Future<void> loginWithApple() async {
    isLoading = true;
    notifyListeners();

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );


      print("credential $credential");
      Future.delayed(Duration(seconds: 2), () {
        socialLogin(credential.identityToken!, false, credential);
      });



      // Here you can use the obtained credential to authenticate the user in your system
      // For example, you can pass the credential to your user API's loginWithApple method
      // final User loggedInUser = await userApi.loginWithApple(
      //   credential.authorizationCode,
      //   credential.identityToken!,
      //   credential.userIdentifier.toString(),
      // );


      // Handle successful login
      // print('Logged in with Apple: ${loggedInUser.token}');
      // isLoading = false;
      // _isLoggedIn = true;
      // result = Result.success(message: 'Login Successful');
    } catch (error) {
      // Handle error
      print('Error logging in with Apple: $error');
      isLoading = false;
      _isLoggedIn = false;
      result = Result.error(error.toString());
    }

    notifyListeners();
  }


  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString('user', userJson);
  }

}