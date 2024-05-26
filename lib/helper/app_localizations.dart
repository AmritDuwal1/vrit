// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class AppLocalizations {
//   final Locale locale;
//
//   AppLocalizations(this.locale);
//
//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }
//
//   static const LocalizationsDelegate<AppLocalizations> delegate =
//   _AppLocalizationsDelegate();
//
//   // Map of localized strings
//   static Map<String, Map<String, String>> _localizedStrings = {
//     'en': {
//       'title': 'Duwal Poultry',
//       'home': 'Home',
//       'hello_world': 'Hello, World!',
//       // Add more English strings as needed
//     },
//     'es': {
//       'title': 'Gallinas Duwal',
//       'home': 'Inicio',
//       'hello_world': '¡Hola, Mundo!',
//       // Add more Spanish strings as needed
//     },
//   };
//
//   // Method to fetch localized string based on key
//   String translate(String key) {
//     return _localizedStrings[locale.languageCode]![key] ?? key;
//   }
// }
//
// class _AppLocalizationsDelegate
//     extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'es'].contains(locale.languageCode);
//   }
//
//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     return AppLocalizations(locale);
//   }
//
//   @override
//   bool shouldReload(_AppLocalizationsDelegate old) => false;
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedStrings = {};

  Future<bool> load() async {
    // Load JSON files based on locale
    String jsonContent = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonContent);

    _localizedStrings[locale.languageCode] =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  // Method to fetch localized string based on key
  String translate(String key) {
    return _localizedStrings[locale.languageCode]![key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}


