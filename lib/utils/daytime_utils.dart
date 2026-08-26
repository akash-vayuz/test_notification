class DaytimeUtils {
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final min = dateTime.minute;

    return '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}';
  }
}
