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

class ConvertInt {
  static String toChineseWeek(int number) {
    int num = number;
    List<String> chinese = [
      '零',
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
      '七',
      '八',
      '九',
      '十',
      ''
    ];
    List<String> unit = ['十', '百', '千'];
    int thousand;
    int hundred;
    int ten;
    int one;
    bool isZero = false;

    String chineseNum = '';
    if (num == null) {
      num = 0;
    }

    if (num >= 10000) {
      num = 0;
      chineseNum = '過大';
    }
    if (num >= 1000) {
      thousand = num ~/ 1000;
      chineseNum += '${chinese[thousand]}${unit[2]}';
    }
    if (num >= 100) {
      num = num % 1000;
      hundred = num ~/ 100;
      if (hundred == 0 && num % 100 != 0) {
        chineseNum += '${chinese[hundred]}';
      } else {
        chineseNum += '${chinese[ten]}${unit[1]}';
      }
    }
    if (num >= 10) {
      num = num % 100;
      ten = num ~/ 10;
      if (ten == 1 && hundred == null && thousand == null) {
        chineseNum += unit[0];
      } else if (ten == 0 && isZero) {
      } else if (ten == 0 && !isZero) {
        chineseNum += chinese[ten];
      } else {
        isZero = false;
        chineseNum += '${chinese[ten]}${unit[0]}';
      }
    }

    one = num % 10;
    if (one > 0) chineseNum += '${chinese[one]}';
    if (num == 0) {
      chineseNum = '';
    } else {
      chineseNum = '第$chineseNum週';
    }

    return chineseNum;
  }

  static String toWeekDay(int week){
    List<String>weekDay = ['', '一','二','三','四','五','六','日'];
    return '星期${weekDay[week]}';
  }
}