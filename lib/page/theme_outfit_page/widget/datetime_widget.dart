import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDateTime extends StatelessWidget {
  final DateTime dateTime;
  final String format;
  final TextStyle? style;

  const FormattedDateTime({
    super.key,
    required this.dateTime,
    this.format = 'dd-MM-yyyy HH:mm:ss',
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    String formatted = DateFormat(format).format(dateTime);

    return Text(
      formatted,
      style: style ?? const TextStyle(fontSize: 14, color: Colors.black),
    );
  }
}
