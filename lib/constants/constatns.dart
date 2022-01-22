import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<List<Color>> gradientList = [
    [Colors.pink, Colors.pink.shade600],
    [Colors.red.shade400, Colors.red.shade500],
    [Color(0xff614385), Color(0xff516395)],
    [Colors.green, Colors.green.shade600],
    [Colors.purple.shade400, Colors.purple.shade600],
  ];

  List<Color> getGradients({required int cid}) {
    if (cid % 5 == 0) {
      gradientList.shuffle();
    }
    return gradientList[cid % 5];
  }

  buildThinDivider() {
    return Container(
      height: 1,
      color: Colors.green.withOpacity(.08),
    );
  }

  buildFatDivider() {
    return Container(
      height: 10,
      color: Colors.green.withOpacity(.1),
    );
  }

  String getDuration({required String? time}) {
    int duration = (double.parse(time!)) ~/ 60;
    int hour = (duration / 60).floor();
    int min = duration - (hour * 60);

    if (hour == 0) {
      return "$min min";
    }

    if (min == 0) {
      return "$hour hours";
    }

    return "$hour hours : $min min";
  }

  void launchURL({required url}) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
