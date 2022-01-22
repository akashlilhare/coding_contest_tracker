import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContestDetailCard extends StatelessWidget {
  final List<Color> colorList;
  final Contest contest;

  const ContestDetailCard(
      {Key? key, required this.contest, required this.colorList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: 8,
        right: 8,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: colorList)),
      child: Column(
        children: [
          Text(
            contest.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12,),
          Text(
            "Start Time : " + constants.getParsedTime(date: contest.startTime),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "End Time : " + constants.getParsedTime(date: contest.endTime),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
      if(contest.duration !=null)    Text(
            "Duration: " + constants.getDuration(time: contest.duration).toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12,),
          ElevatedButton(
            child: Text(
              "View Contest",
              style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 1,
              minimumSize: Size(0,40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              primary: Colors.white,
            
            ),
            onPressed: () {
              constants.launchURL(url: contest.url);
            },
          )
        ],
      ),
    );
  }
}
