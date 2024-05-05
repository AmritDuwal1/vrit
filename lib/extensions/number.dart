

extension DynamicExtension on dynamic {
  double? toDoubleOrZero() {
    if (this is num) {
      return this.toDouble();
    } else if (this is String) {
      try {
        return double.parse(this);
      } catch (_) {
        return 0;
      }
    } else {
      return 0;
    }
  }
}

extension IntExtension on dynamic {
  int toIntOrZero() {
    if (this is num) {
      return this.toInt();
    } else if (this is String) {
      try {
        return int.parse(this);
      } catch (_) {
        return 0;
      }
    } else {
      return 0;
    }
  }

  String toStr() {
    return this.toString();
  }
}

extension NullableIntExtension on int? {
  String? toStr() {
    return this == null ? "" : this?.toString();
  }
}

int calculateNumberOfDays(DateTime checkInDate, DateTime checkOutDate) {
  // Calculate the difference
  Duration difference = checkOutDate.difference(checkInDate);

  // Get the number of days
  int numberOfDays = difference.inDays;

  return numberOfDays;
}

