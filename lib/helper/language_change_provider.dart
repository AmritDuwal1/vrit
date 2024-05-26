import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class LanguageChangeProvider extends InheritedWidget {
  final Function(Locale) changeLanguage;

  LanguageChangeProvider({
    required Widget child,
    required this.changeLanguage,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static LanguageChangeProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LanguageChangeProvider>();
}
