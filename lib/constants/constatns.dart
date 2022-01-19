import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
  String getParsedTime({required String date}) {
    String currTime;
    try {
      currTime = DateTime.tryParse(date) == null
          ? DateTime(2000, 08, 12).toString()
          : DateTime.tryParse(date).toString();
    } on Error {
      currTime = date.toString();
    }
    var format = DateFormat.yMMMEd();
    String dateString = format.format(DateTime.parse(currTime));
    return dateString;
  }

  String? getDuration({required String startTime, required String endTime}) {
    DateTime initTime;
    DateTime overTime;

    try {
      initTime = DateTime.parse(startTime);
      overTime = DateTime.parse(endTime);
    } on Error {
      return null;
    }

    int duration = overTime.difference(initTime).inMinutes;
    int hour = (duration / 60).floor();
    int min = duration - (hour * 60);

    if (hour == 0) {
      return "$min min";
    }
    return "$hour hours : $min min";
  }

  void launchURL({required url}) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
