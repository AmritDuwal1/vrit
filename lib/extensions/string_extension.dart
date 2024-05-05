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
