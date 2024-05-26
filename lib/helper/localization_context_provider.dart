import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// // Create a provider to hold the current BuildContext
// class LocalizationContextProvider extends StatelessWidget {
//   final Widget child;
//   final BuildContext context;
//
//   LocalizationContextProvider({
//     required this.child,
//     required this.context,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Provider.value(
//       value: context,
//       child: child,
//     );
//   }
// }

class LocalizationContextProvider extends ChangeNotifier {
  late BuildContext _context;

  BuildContext get context => _context;

  void setContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }
}
