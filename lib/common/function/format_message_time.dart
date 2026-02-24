import 'package:intl/intl.dart';

class FormatMessageTime {
  static String onConvert(String dateString) {
    try {
      String dateTimeString = dateString == "" ? DateTime.now().toString() : dateString;

      DateTime dateTime = DateTime.parse(dateTimeString).toLocal();

      DateTime today = DateTime.now();

      bool isToday = dateTime.year == today.year && dateTime.month == today.month && dateTime.day == today.day;

      if (isToday) {
        DateFormat timeFormatter = DateFormat('hh:mm a');
        return timeFormatter.format(dateTime);
      } else {
        DateFormat dateFormatter = DateFormat('dd/MM/yy');
        return dateFormatter.format(dateTime);
      }
    } catch (e) {
      return "";
    }
  }
}
