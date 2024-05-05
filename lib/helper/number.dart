

extension NrsFormatting on dynamic {
  String formatToNrs() {
    // Convert to double if the value is a string
    double doubleValue = this is String ? double.parse(this) : this.toDouble();

    // Format the double value
    String formattedValue = doubleValue.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'^(\d+)(\.\d+)?0+$'),
          (Match match) => '${match[1]}'.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]},',
      ),
    );

    // Remove the decimal part if it's .00
    formattedValue = formattedValue.replaceAll(RegExp(r'\.00$'), '');

    // Return the formatted string
    return 'Rs $formattedValue';
  }
}
