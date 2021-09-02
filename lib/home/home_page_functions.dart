timeOfDateTime(DateTime d) {
  return Duration(hours: d.hour, minutes: d.minute);
}

dateOfDateTime(DateTime d) {
  return DateTime.utc(d.year, d.month, d.day);
}

getMon(DateTime today) {
  int daysAfter = today.weekday - 1;
  return DateTime.utc(today.year, today.month, today.day - daysAfter);
}

class ConvertString {
  static Duration toDuration(String string) {
    int hour = 0;
    int minute = 0;
    List<String> time = string.split(':');
    if (time.length >= 2) {
      hour = int.parse(time[0]);
      minute = int.parse(time[1]);
    }
    return Duration(hours: hour, minutes: minute);
  }
}

class ConvertDuration {
  static String toShortTime(Duration d) {
    List<String> time = d.toString().split(':');
    return '${time[0].padLeft(2, '0')}:${time[1]}';
  }
}
