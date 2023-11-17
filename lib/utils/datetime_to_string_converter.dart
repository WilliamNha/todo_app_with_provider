import 'package:intl/intl.dart';

class DateTimeToStringConverter {
  static String convertStrinToDateTime(DateTime datetimeSelected) {
    String datetime;
    datetime = DateFormat('HH:mm').format(datetimeSelected);
    return datetime;
  }
}
