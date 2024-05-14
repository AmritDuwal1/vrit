import 'package:intl/intl.dart';


extension DateExtension on String {
  String formatDateString([String format = 'yMMMd']) {
    final parsedDate = DateTime.parse(this);
    return DateFormat(format).format(parsedDate);
  }
}
