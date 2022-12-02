import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomDateTimeFormatter {
  static stringToDateTime(String timeString) {
    final dateTime = DateTime.parse(timeString).toUtc();
    final dateTimeDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateFormat dateFormat;
    if (dateTimeDay == today) {
      //if date is today, show how many hours ago
      final hourAgo = dateTime.subtract(const Duration(minutes: 60));
      return timeago.format(hourAgo);
    } else {
      //if date is other day, show day month year
      dateFormat = DateFormat("d MMM yyyy");
    }
    return dateFormat.format(dateTime);
  }
}
