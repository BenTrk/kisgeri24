class HomeScreenUtils {
  static int getEpochFromDateTime(String dateString) {
    DateTime dateTime =
        DateTime.parse(dateString.split(" - ")[0]); // Extracting the date
    String timeString = dateString.split(" - ")[1]; // Extracting the time

    List<String> timeParts = timeString.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    dateTime = dateTime.add(Duration(hours: hour, minutes: minute));

    return dateTime.millisecondsSinceEpoch;
  }
}
