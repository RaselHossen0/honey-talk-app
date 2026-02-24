import 'package:intl/intl.dart';

class CustomFormatDate {
  static String onConvert(String value) {
    DateTime dateTime = DateTime.parse(value).toLocal();
    String formattedDate = DateFormat("dd-MM-yy HH:mm").format(dateTime);
    return formattedDate;
  }
}
