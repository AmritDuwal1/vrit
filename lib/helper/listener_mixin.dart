import 'package:flutter/material.dart';
import 'package:poultry/path_collection.dart';

mixin ListenerMixin<T extends StatefulWidget> on State<T> {
  ViewModel get viewModel;

  void listenerFunction() {
    // Callback logic
    showResultDialog(context, viewModel.result!, () {
      if (viewModel.result!.isSuccess) {
        Navigator.pop(context, true);
      }
      viewModel.result = null;
    });
  }

  void initListener() {
    viewModel.addListener(listenerFunction);
  }

  void removeListener() {
    viewModel.removeListener(listenerFunction);
  }

  @override
  void initState() {
    super.initState();
    initListener();
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }
}


class ViewModel extends ChangeNotifier {
  Result? result;

  // Example method to simulate updating the result
  void updateResult(Result newResult) {
    result = newResult;
    notifyListeners();
  }
}
// class Result {
//   final bool isSuccess;
//
//   Result(this.isSuccess);
// }

