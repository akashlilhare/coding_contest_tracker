import 'dart:convert';

import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ContestProvider with ChangeNotifier {
  DataConnectionStatus connectionStatus = DataConnectionStatus.loading;
  List<Contest> platformContestList = [];
  List<Contest> runningContest = [];
  List<Contest> upcoming24Contest = [];
  List<Contest> allContest = [];

  readPlatformContest({required String tag}) async {
    platformContestList = [];
    String url = "https://kontests.net/api/v1/$tag";
    connectionStatus = DataConnectionStatus.loading;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        connectionStatus = DataConnectionStatus.success;
        var jsonData = json.decode(response.body);
        platformContestList = fromJson(jsonData);
      } else {
        connectionStatus = DataConnectionStatus.error;
      }
    } on Error {
      connectionStatus = DataConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  readAllContest() async {
    allContest = [];
    String url = "https://kontests.net/api/v1/all";
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        connectionStatus = DataConnectionStatus.success;
        var jsonData = json.decode(response.body);
        allContest = fromJson(jsonData);
      } else {
        connectionStatus = DataConnectionStatus.error;
      }
    } on Error {
      connectionStatus = DataConnectionStatus.error;
    } finally {}
  }

  setData() async {
    runningContest = [];
    upcoming24Contest = [];
    allContest = [];
    connectionStatus = DataConnectionStatus.loading;
    notifyListeners();
    await readAllContest();
    print("here  ");
    print(allContest.length);
    for (var contest in allContest) {
      if (contest.status == "CODING") {
        runningContest.add(contest);
      } else {
        if (contest.in24Hours == "Yes") {
          upcoming24Contest.add(contest);
        }
      }
    }
    notifyListeners();
  }

  List<Contest> fromJson(List<dynamic> jsonList) {
    List<Contest> tempList = [];
    for (var json in jsonList) {
      tempList.add(Contest(
        name: json['name'],
        url: json['url'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        duration: json['duration'],
        site: json['site'] ?? ".",
        in24Hours: json['in_24_hours'],
        status: json['status'],
      ));
    }
    return tempList;
  }
}

enum DataConnectionStatus { success, error, loading }

