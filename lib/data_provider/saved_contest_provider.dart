import 'dart:convert';

import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedContestProvider with ChangeNotifier {
  List<ContestSource> contestProviderList = [];

  saveData({required List<ContestSource> list}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = encodeContestData(srcList: list);
    await prefs.setString('save_contest', encodedData);
  }

  readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('save_contest');
    print(savedData.toString());
    if(savedData == null){
      contestProviderList = allProvider;
    }else{
      final List<ContestSource> savedList = decodeContestData(data: savedData);
      contestProviderList = savedList;
    }
    notifyListeners();
  }
}

String encodeContestData({required List<ContestSource> srcList}) {
  List<dynamic> jsonList = [];

  srcList.forEach((src) {
    Map<String, String> jsonMap = {};
    jsonMap = {
      "key": src.key,
      "title": src.title,
      "is_selected": src.isSelected.toString()
    };
    jsonList.add(jsonMap);
  });
  String jsonString = json.encode(jsonList);
  print(jsonString);
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


List<ContestSource> allProvider = [
  ContestSource(key: "codeforces", title: 'CodeForces',isSelected: false,imgSrc: "assets/images/code_forces.png"),
  ContestSource(title: "CodeForces Gym", key: "codeforces_gym",isSelected: false,imgSrc: "assets/images/code_forces_gym.png"),
  ContestSource(title: "TopCoder", key: "top_coder",isSelected: false,imgSrc: "assets/images/top_coder.jpg"),
  ContestSource(title: "AtCoder", key: "at_coder",isSelected: false,imgSrc: "assets/images/at_coders.png"),
  ContestSource(title: "CodeChef", key: "code_chef",isSelected: false,imgSrc: "assets/images/code_chef.jpg"),
  ContestSource(title: "CS Academy", key: "cs_academy",isSelected: false,imgSrc: "assets/images/cs_acadmy.png"),
  ContestSource(title: "HackerRank", key: "hacker_rank",isSelected: false,imgSrc: "assets/images/hacker_rank.png"),
  ContestSource(title: "HackerEarth", key: "hacker_earth",isSelected: false,imgSrc: "assets/images/hacker_earth.png"),
  ContestSource(title: "Kick Start", key: "kick_start",isSelected: false,imgSrc: "assets/images/kick_start.jpg"),
  ContestSource(title: "LeetCode", key: "leet_code",isSelected: false,imgSrc: "assets/images/leet_code.png"),
];