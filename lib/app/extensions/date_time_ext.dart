import 'package:super_ui_kit/super_ui_kit.dart';

extension DateTimeFormatting on DateTime {
  String formatCustom(String format) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  String passedTime() {
    DateTime now = DateTime.now();
    int differenceInDays = now.difference(this).inDays;
    if (differenceInDays <= 31) {
      return '$differenceInDays days';
    }

    int months = (now.year - year) * 12;
    months -= month;
    months += now.month;
    if (months > 12) return "$months months";

    int years = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      years--;
    }
    return "$years years";
  }
}
