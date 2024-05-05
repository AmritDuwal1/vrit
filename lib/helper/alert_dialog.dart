import 'package:flutter/material.dart';

// class AlertDialogUtils {
//   static Future<void> showConfirmationDialog(
//       BuildContext context,
//       String title,
//       String content,
//       VoidCallback onConfirm, {
//         String cancelButtonText = 'Cancel',
//         String confirmButtonText = 'Okay',
//       }) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text(cancelButtonText),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle confirmation
//                 onConfirm(); // Call the provided callback
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text(confirmButtonText),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


class AlertDialogUtils {
  static Future<void> showConfirmationDialog(
      BuildContext context,
      String title,
      String content,
      VoidCallback onConfirm, {
        String cancelButtonText = 'Cancel',
        String confirmButtonText = 'Okay',
        bool showCancelButton = true,
      }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (showCancelButton)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(cancelButtonText),
              ),
            TextButton(
              onPressed: () {
                // Handle confirmation
                onConfirm(); // Call the provided callback
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(confirmButtonText),
            ),
          ],
        );
      },
    );
  }
}
