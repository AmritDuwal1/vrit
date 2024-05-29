
import 'package:flutter/material.dart';
import 'package:poultry/api/user_api.dart';
import 'package:poultry/path_collection.dart';

class EditProfileViewModel extends ChangeNotifier {
  final UserAPI userApi = UserAPI();
  bool isLoading = false;
  User? user;
  FlutterError? error;

  void updateProfile(
      email,
      firstName,
      lastName,
      userName,
      phoneNumber,
      birthDate,
      imagePath,) {
    isLoading = true;
    notifyListeners();

    userApi.updateUser(
      email,
      firstName,
      lastName,
      userName,
      phoneNumber,
      birthDate,
      null,
          (user) {
        GlobalConstants.saveUser(user);

            isLoading = false;
        this.error = FlutterError('Update user successful.');
        notifyListeners();
      },
          (error) {
            isLoading = false;
            this.error = error;
            notifyListeners();
      },
    );
  }
}
