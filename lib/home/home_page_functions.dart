Duration timeOfDateTime(DateTime d) {
  return Duration(hours: d.hour, minutes: d.minute);
}

DateTime dateOfDateTime(DateTime d) {
  return DateTime.utc(d.year, d.month, d.day);
}

DateTime getMon(DateTime today) {
  int daysAfter = today.weekday - 1;
  return DateTime.utc(today.year, today.month, today.day - daysAfter);
}


