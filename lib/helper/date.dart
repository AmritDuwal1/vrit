import 'package:intl/intl.dart';

// String toDateStr(DateTime date) {
//   DateFormat dateFormat = DateFormat('EEE dd MMM');
//   return dateFormat.format(date);
// }

import 'package:intl/intl.dart';

import 'package:poultry/path_collection.dart';

extension DateFormatExtension on DateTime {
  String toDateStr({String format = 'EEE dd MMM'}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }
}