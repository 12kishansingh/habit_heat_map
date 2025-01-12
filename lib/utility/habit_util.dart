// given a habit lsit of compltetion days is the habit complteted today
bool isHabitCompletedToday(List<DateTime> compltedDays) {
  final today = DateTime.now();
  return compltedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}
