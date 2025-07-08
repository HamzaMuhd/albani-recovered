String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

  if (hours > 0) {
    return '$hours:$minutes:$seconds';
  } else {
    return '$minutes:$seconds';
  }
}

Duration parseDuration(String input) {
  final parts = input.split(':').map(int.tryParse).toList();

  if (parts.contains(null)) return Duration.zero;

  if (parts.length == 2) {
    // mm:ss
    return Duration(minutes: parts[0]!, seconds: parts[1]!);
  } else if (parts.length == 3) {
    // hh:mm:ss
    return Duration(hours: parts[0]!, minutes: parts[1]!, seconds: parts[2]!);
  } else {
    return Duration.zero;
  }
}
