import 'package:poultry/extensions/result.dart';
import 'package:poultry/path_collection.dart';

// void showResultDialog(BuildContext context, Result result, VoidCallback callback) {
//   String title = result.isSuccess ? 'Success' : 'Error';
//   String message = result.message ?? "Something Went Wrong!";
//
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 callback(); // Call the callback function provided
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   });
// }

void showResultDialog(
    BuildContext context,
    Result result,
    VoidCallback okCallback, {
      VoidCallback? cancelCallback,
      String okButtonText = 'OK',
      String cancelButtonText = 'Cancel',
    }) {
  String title = result.isSuccess ? 'Success' : 'Error';
  String message = result.message ?? "Something Went Wrong!";

  WidgetsBinding.instance!.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                okCallback(); // Call the OK callback function provided
              },
              child: Text(okButtonText),
            ),
            if (cancelCallback != null) // Only show cancel button if callback is provided
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  cancelCallback(); // Call the cancel callback function provided
                },
                child: Text(cancelButtonText),
              ),
          ],
        );
      },
    );
  });
}
