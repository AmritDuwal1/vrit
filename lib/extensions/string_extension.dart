import 'package:poultry/helper/app_localizations.dart';

import '../path_collection.dart';

extension ExtString on String {
  bool get isNotNull {
    return this != null;
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}



extension CapitalizeFirstLetterExtension on String {
  String get capitalizeFirstLetter =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';


  String get formatAndCapitalize =>
      isEmpty ? '' :  replaceAll('_', ' ').capitalizeFirstLetter;

  String get reverseFormatAndCapitalize =>
      isEmpty ? '' :  replaceAll(' ', '_').toLowerCase();

}

extension CapitalizeFirstLetterNullableExtension on String? {
  String get capitalizeFirstLetter {
    if (this == null || (this?.isEmpty ?? true)) {
      return "";
    } else {
      return '${this![0].toUpperCase()}${this?.substring(1)}';
    }
  }
}


extension OptionslStringExtensions on String? {
  bool get isUrl {
    if (this == null) {
      return false;
    }
    final Uri? uri = Uri.tryParse(this!);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

}

extension StringExtensions on String {
  bool get isUrl {
    final Uri? uri = Uri.tryParse(this);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }
}

// // Define the extension on String
// extension LocalizedStringExtension on String {
//   String translate(BuildContext context) {
//     return AppLocalizations.of(context)?.translate(this) ?? this;
//   }
// }

// Define a global variable for storing context
BuildContext? _appLocalizationContext;


// Extension on String for localization
extension LocalizationExtension on String {
  // Setter for the context
  static set context(BuildContext context) {
    _appLocalizationContext = context;
  }

  // Getter for the context
  static BuildContext get context => _appLocalizationContext!;

  // Method to translate the string
  String get translate {
    return AppLocalizations.of(context)?.translate(this) ?? this;
  }
}




// extension NepaliPhoneNumberValidation on String {
//   bool get isValidNepaliPhoneNumber {
//     // Regular expression to match a valid Nepali phone number
//     RegExp regex = RegExp(r'^98[4-9][0-9]{7}$');
//     return regex.hasMatch(this);
//   }
// }

extension NepaliPhoneNumberValidation on String? {
  bool get isValidNepaliPhoneNumber {
    if (this == null) return false;
    // Regular expression to match a valid Nepali phone number
    RegExp regex = RegExp(r'^98[4-9][0-9]{7}$');
    return regex.hasMatch(this!);
  }
}