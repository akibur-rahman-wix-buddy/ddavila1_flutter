String formatCountdown(DateTime endTime) {
  final now = DateTime.now();
  final difference = endTime.difference(now);

  if (difference.isNegative) {
    return "Auction ended";
  }

  final days = difference.inDays;
  final hours = difference.inHours % 24;
  final minutes = difference.inMinutes % 60;
  final seconds = difference.inSeconds % 60;

  return "${days}d ${hours}h ${minutes}m ${seconds}s";
}
Stream<String> getLiveCountdownStream({required String isoTime}) {
  final endTime = DateTime.parse(isoTime);
  return Stream.periodic(const Duration(seconds: 1), (_) {
    return formatCountdown(endTime);
  });
}
