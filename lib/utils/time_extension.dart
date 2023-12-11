extension DateTimeExtension on DateTime {
  DateTime addMonths(int months) {
    var (int year, int month, int day) = (this.year, this.month, this.day);

    month += months;
    while (month > 12) {
      month -= 12;
      year++;
    }

    // Проверяем, чтобы день был валидным для нового месяца
    final daysInMonth = DateTime(year, month + 1, 0).day;
    if (day > daysInMonth) day = daysInMonth;

    return DateTime(year, month, day);
  }
}
