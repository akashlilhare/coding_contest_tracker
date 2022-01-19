import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'error_page.dart';

class ContestDetailPage extends StatefulWidget {
  final String title;
  final String src;

  const ContestDetailPage({Key? key, required this.title, required this.src})
      : super(key: key);

  @override
  _ContestDetailPageState createState() => _ContestDetailPageState();
}

class _ContestDetailPageState extends State<ContestDetailPage> {
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ContestProvider>(context, listen: false)
          .readPlatformContest(tag: widget.src);
      // Add Your Code here.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

  String  getDateTime({required String date}){
      String  currTime;
    try{
      currTime =  DateTime.tryParse(date) == null? DateTime(2000,08,12).toString():DateTime.tryParse(date).toString();
    }on Error{
      currTime = date.toString();
    }
      var format = DateFormat.yMMMEd();
      String dateString = format.format(DateTime.parse(currTime));
    return dateString;
    }
    buildCard({required Contest contest}) {
      return Container(
        margin: EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),

        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
        child: Column(
          children: [
            Text(
              contest.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),

            Text(
            "Start Time : "+  getDateTime(date: contest.startTime),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),

            Text(
              "End Time : " + getDateTime(date: contest.endTime),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),

            Text(
              "Duration: " + getDateTime(date: contest.duration),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),

            ElevatedButton(child: Text("View Contest"),onPressed: (){},)

          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
        body: Consumer<ContestProvider>(builder: (context, data, _) {
          return SingleChildScrollView(
            child: data.connectionStatus == ConnectionStatus.loading
                ? CircularProgressIndicator()
                : data.connectionStatus == ConnectionStatus.error
                    ? ErrorPage()
                    : Column(
                        children: data.platformContestList.map((contest) {
                          return buildCard(contest: contest);
                        }).toList(),
                      ),
          );
        }),
      ),
    );
  }
}
