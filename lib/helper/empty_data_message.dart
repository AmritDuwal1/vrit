import 'package:flutter/material.dart';

class EmptyDataMessage extends StatelessWidget {
  final String message;

  const EmptyDataMessage({Key? key, this.message = 'No data found.'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
