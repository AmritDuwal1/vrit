// import 'package:flutter/material.dart';
// import 'package:poultry/path_collection.dart';
//
// mixin ListenerMixin<T extends StatefulWidget> on State<T> {
//   BaseViewModel get viewModel;
//
//   void listenerFunction() {
//     // Callback logic
//     showResultDialog(context, viewModel.result!, () {
//       if (viewModel.result!.isSuccess) {
//         Navigator.pop(context, true);
//       }
//       viewModel.result = null;
//     });
//   }
//
//   void initListener() {
//     viewModel.addListener(listenerFunction);
//   }
//
//   void removeListener() {
//     viewModel.removeListener(listenerFunction);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initListener();
//   }
//
//   @override
//   void dispose() {
//     removeListener();
//     super.dispose();
//   }
// }
//
//
// // class BaseViewModel extends ChangeNotifier {
// //   Result? result;
// //
// //   // Example method to simulate updating the result
// //   void updateResult(Result newResult) {
// //     result = newResult;
// //     notifyListeners();
// //   }
// // }
// //
// //
//
//
// // class BaseViewModel extends ChangeNotifier {
// //   Result? _result;
// //
// //   // Getter for result
// //   Result? get result => _result;
// //
// //   // Setter for result
// //   set result(Result? value) {
// //     _result = value;
// //     notifyListeners(); // Notify listeners when result changes
// //   }
// // }
//
//
// class BaseViewModel extends ChangeNotifier {
//   Result? _result;
//
//   // Getter for result
//   Result? get result => _result;
//
//   // Setter for result
//   set result(Result? value) {
//     _result = value;
//     // showResultDialog(context, viewModel.result!, () {
//     //   result = null;
//     // });
//   }
//
//
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertManager extends ChangeNotifier {
  String? _alertMessage;

  String? get alertMessage => _alertMessage;

  void showAlert(String message) {
    _alertMessage = message;
    notifyListeners();
  }

  void clearAlert() {
    _alertMessage = null;
    notifyListeners();
  }
}

class AlertListener extends StatelessWidget {
  final Widget child;

  AlertListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlertManager>(
      builder: (context, alertManager, _) {
        if (alertManager.alertMessage != null) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(alertManager.alertMessage!),
                duration: Duration(seconds: 4),
              ),
            );
            alertManager.clearAlert();
          });
        }
        return child;
      },
    );
  }
}
