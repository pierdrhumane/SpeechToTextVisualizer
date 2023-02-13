int getTime(String timeString) {
  String[] parts = timeString.split(":");
  int minutes = Integer.parseInt(parts[0]);
  int seconds = Integer.parseInt(parts[1].split("\\.")[0]);
  int milliseconds = Integer.parseInt(parts[1].split("\\.")[1]);
  return minutes * 60 * 1000 + seconds * 1000 + milliseconds;
}
