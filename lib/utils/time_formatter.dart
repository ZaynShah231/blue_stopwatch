class TimeFormatter {
  static String format(int milliseconds) {
    int centiseconds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / 60000).truncate();

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String centiStr = centiseconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$centiStr";
  }
}