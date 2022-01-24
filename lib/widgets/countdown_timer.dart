import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ContestCardHeader extends StatelessWidget {
  final String startTime;
  final String siteName;
  final String endTime;
  final List<Color> colors;
  final String status;

  const ContestCardHeader(
      {Key? key,
      required this.startTime,
      required this.siteName,
      required this.endTime,
      required this.colors,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? buildTimeList() {
      if (DateTime.tryParse(startTime) == null) {
        return null;
      }
      try {
        var temp = DateTime.parse(startTime)
            .toLocal()
            .difference(DateTime.now())
            .inMinutes;
        bool isRunning = temp.isNegative;
        int time = isRunning
            ? DateTime.parse(endTime)
                .toLocal()
                .difference(DateTime.now())
                .inMilliseconds
            : DateTime.parse(startTime)
                .toLocal()
                .difference(DateTime.now())
                .inMilliseconds;
        int contestTime = DateTime.now().millisecondsSinceEpoch + time;
        return CountdownTimer(
          endTime: contestTime,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            String res = "";
            if (time == null) {
              return const  Text(
                "Contest Over",
                style:  TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -.5,
                    color: Colors.white),
              );
            } else if (time.days != null) {
              res = 'days:${time.days}, hr:${time.hours}, min:${time.min}, sec:${time.sec}';
            } else if (time.hours != null) {
              res = "hours:${time.hours}, min:${time.min}, sec:${time.sec}";
            } else if (time.min == null) {
              res = "min:0, sec:${time.sec}";
            } else {
              res = "min:${time.min}, sec:${time.sec}";
            }
            return Text(
              isRunning ? "End in: " + res : "Starts in: " + res,
              style: TextStyle(
                  fontSize:time.days == null?14: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing:time.days == null?-1.0: -1.1,
                  color: Colors.white),
            );
          },
        );
      } on Error {
        return null;
      }
    }

    buildStatusTag() {
      getTag() {
        if (DateTime.parse(endTime).difference(DateTime.now()).isNegative) {
          return "Finished";
        }
        return status == "CODING" ? "Running" : "Upcoming";
      }

      return Positioned(
          right: 0,
          child: Container(
              decoration:const  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                getTag(),
                style: const TextStyle(color: Colors.black),
              )));
    }



    return Stack(
      children: [
        Container(
          padding:const  EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
              borderRadius:const  BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(colors: colors)),
          child: ListTile(
            contentPadding:  const EdgeInsets.symmetric(horizontal: 12.0),
            minLeadingWidth: 1,
            leading: CircleAvatar(
              child: Text(
                siteName[0],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              backgroundColor: Colors.white,
            ),
            title: Text(
              siteName,
              style: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),
            ),
            subtitle: buildTimeList(),
          ),
        ),
        buildStatusTag(),

      ],
    );
  }
}
