import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
  String getParsedTime({required String date}) {
    String? currTime;
    try {
      currTime =  DateTime.tryParse(date) == null ?null:DateTime.tryParse(date).toString();
    } on Error {
      currTime = date.toString();
    }
    if(currTime == null){
      return date.toString();
    }
    var timeFormat = DateFormat.jm();
    var dateFormat = DateFormat.yMMMd();
    String timeString = timeFormat.format(DateTime.parse(currTime).toLocal());
    String dateString = dateFormat.format(DateTime.parse(currTime).toLocal());
    return "$dateString, $timeString";
  }

  List<List<Color>> gradientList = [

    [Colors.red.shade400, Colors.red.shade500],
    [Color(0xff614385), Color(0xff516395)],
    [Colors.pink, Colors.pink.shade600],
    [Colors.green, Colors.green.shade600],
    [Colors.purple.shade400, Colors.purple.shade600],
  ];

  List<Color> getGradients({required int cid}) {
    List<Color> temp =  gradientList[cid % 5];

    if (cid % 5 == 0) {
      gradientList.shuffle();
    }
    return temp;
  }

  buildThinDivider() {
    return Container(
      height: 1,
      color: Colors.green.withOpacity(.08),
    );
  }

  buildFatDivider() {
    return Container(
      height: 16,
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
