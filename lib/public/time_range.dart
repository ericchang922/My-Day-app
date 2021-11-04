class TimeRange {
  // 時間範圍
  DateTime time;
  TimeRange(this.time);
  bool inTime(DateTime start, DateTime end) {
    bool isInTime = true;
    DateTime _start = start;
    DateTime _end = end;

    if (_start.isAfter(_end)) {
      _start = end;
      _end = start;
    } // 若開始在結束之後則交換位置

    if (time.isBefore(start)) isInTime = false;
    if (time.isAfter(end)) isInTime = false;
    // 時間要在區間開始之後、結束之前
    // => 不能在開始前和結束後
    return isInTime;
  }

  bool notAfter(DateTime dateTime) {
    bool isNotAfter = true;
    if (time.isAfter(dateTime)) isNotAfter = false;
    return isNotAfter;
  }

  bool notBefore(DateTime dateTime) {
    bool isNotBefore = true;
    if (time.isBefore(dateTime)) isNotBefore = false;
    return isNotBefore;
  }
}