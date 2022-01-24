import 'dart:convert';

import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedContestProvider with ChangeNotifier {
  List<ContestSource> savedContestList = [];
  List<ContestSource> selectedContestList = [];

  saveData({required List<ContestSource> list}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = encodeContestData(srcList: list);
    await prefs.setString('save_contest', encodedData);
  }

  readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('save_contest');
    if (savedData == null) {
      savedContestList = allContestList;
    } else {
      final List<ContestSource> savedList = decodeContestData(data: savedData);
      savedContestList = savedList;
    }
    notifyListeners();
  }

  getSelectedSites()async {
    selectedContestList = [];
   await readData();
    for (var contest in savedContestList) {
      if (contest.isSelected) {
        selectedContestList.add(contest);
      }
    }
    notifyListeners();
  }

  toggleFilter({required bool value, required ContestSource contest}) {
    int idx = savedContestList.indexOf(contest);
    savedContestList[idx] = ContestSource(
        title: contest.title,
        imgSrc: contest.imgSrc,
        isSelected: value,
        key: contest.key);
    notifyListeners();
  }
}

String encodeContestData({required List<ContestSource> srcList}) {
  List<dynamic> jsonList = [];

  for (var src in srcList) {
    Map<String, String> jsonMap = {};
    jsonMap = {
      "key": src.key,
      "title": src.title,
      "is_selected": src.isSelected.toString()
    };
    jsonList.add(jsonMap);
  }
  String jsonString = json.encode(jsonList);

  return jsonString;
}

decodeContestData({required String data}) {
  List<ContestSource> savedList = [];
  List<dynamic> jsonData = json.decode(data);
  for (var data in jsonData) {
    savedList.add(ContestSource(
        title: data["title"],
        key: data["key"],
        isSelected: data["is_selected"] == "true"? true:false, imgSrc: ''));
  }

  return savedList;
}


