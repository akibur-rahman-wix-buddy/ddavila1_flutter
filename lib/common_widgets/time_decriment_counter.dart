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
// Stream<String> getLiveCountdownStream({required String isoTime}) {
//   final endTime = DateTime.parse(isoTime);
//   return Stream.periodic(const Duration(seconds: 1), (_) {
//     return formatCountdown(endTime);
//   });
// }



Stream<String> getLiveCountdownStream({required dynamic isoTime}) {


  print(">>>>>>>>>>>>>. bit time is ${isoTime}");

  final endTime = DateTime.parse(isoTime);
  return Stream.periodic(const Duration(seconds: 1), (_) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    // Return '00:00:00' if the countdown has ended
    if (difference.isNegative) {
      return '00:00:00';
    }

    // Format the countdown
    final hours = difference.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = difference.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = difference.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  });
}


bool isTimeFinished(String dateTimeString) {
  DateTime auctionEndTime = DateTime.parse(dateTimeString).toUtc();
  DateTime now = DateTime.now().toUtc();
  return now.isAfter(auctionEndTime);
}






// bool isTimeFinished(String dateTimeString) {
//
//
//   print(">>>>>>>>>>>>>>>>>>>>>>>> here is the last time ${dateTimeString}");
//
//   DateTime inputTime = DateTime.parse(dateTimeString);
//   DateTime now = DateTime.now().toUtc(); // current time in UTC
//
//   return now.isBefore(inputTime); // true = not finished, false = expired
// }

// void main() {
//   String myTime = "2025-08-02T00:00:00.000000Z";
//
//   bool isValid = isTimeValid(myTime);
//
//   print("Is time valid? $isValid");
// }
