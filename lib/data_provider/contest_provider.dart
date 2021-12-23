import 'dart:convert';

import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ContestProvider with ChangeNotifier {
  late ConnectionStatus connectionStatus;
  List<Contest> contestList = [];

  readContestData({ required  String tag}) async {
     contestList = [];
   String defaultTag = "all";
   print("here ");
   print(tag);
    String url = "https://kontests.net/api/v1/$tag";
    connectionStatus = ConnectionStatus.loading;
    notifyListeners();
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        connectionStatus = ConnectionStatus.success;
        var jsonData = json.decode(response.body);
        fromJson(jsonData);

      } catch (e) {
        print(e);
      } finally {}
    } else {
      connectionStatus = ConnectionStatus.error;
    }

    print(connectionStatus.toString());
    print(contestList[0].status);
    notifyListeners();
  }

  fromJson(List<dynamic> jsonList) {
    for (var json in jsonList) {
      contestList.add(Contest(
        name: json['name'],
        url: json['url'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        duration: json['duration'],
        site: json['site']??".",
        in24Hours: json['in_24_hours'],
        status: json['status'],
      ));
    }
  }
}

enum ConnectionStatus { success, error, loading }

