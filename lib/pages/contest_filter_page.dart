import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class ContestFilterPage extends StatefulWidget {
  const ContestFilterPage({Key? key}) : super(key: key);

  @override
  _ContestFilterPageState createState() => _ContestFilterPageState();
}

class _ContestFilterPageState extends State<ContestFilterPage> {
  @override
  void initState() {
    Provider.of<SavedContestProvider>(context, listen: false).readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedContestProvider>(builder: (context, data, _) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              elevation: 1,
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                    child: Text(
                      "Select Contests",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  CloseButton(),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Wrap(
                children: allProvider
                    .map((contest) {
                      bool isPresent(){
                        for (var e in data.contestProviderList) {
                          if(contest.title == e.title ){
                            if(contest.isSelected == e.isSelected){
                              return true;
                            }
                          }
                        }
                        return false;
                      }
                      return Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: FilterChip(
                              selected: isPresent(),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.02),
                              selectedColor: Theme.of(context).primaryColor,
                              showCheckmark: false,
                              labelStyle: TextStyle(
                                  color: isPresent()
                                      ? Colors.white
                                      : Colors.black87),
                              label: Text(contest.title),
                              onSelected: (val) {
                                contest.isSelected = val;
                                setState(() {});
                              }),
                        );
                    })
                    .toList(),
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  TextButton(
                    child: Text("Select All"),
                    onPressed: () {
                      allProvider.forEach((contest) {
                        contest.isSelected = true;
                      });
                      setState(() {});
                    },
                  ),
                  TextButton(
                    child: Text("Reset"),
                    onPressed: () {
                      allProvider.forEach((contest) {
                        contest.isSelected = false;
                      });
                      setState(() {});
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text("APPLY"),
                    onPressed: () {
                 List<ContestSource>     appliedList = [];
                 allProvider.forEach((contest) {
                   if(contest.isSelected == true){
                     appliedList.add(contest);
                   }
                 });
                      Provider
                          .of<SavedContestProvider>(context, listen: false).saveData(list:appliedList );
                      print("here");
                      appliedList.forEach((element) {print(element.title+" "+ element.isSelected.toString());});
                      Navigator.of(context).pop();
                 Route route = MaterialPageRoute(builder: (context) =>HomePage());
                 Navigator.pushReplacement(context, route);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    });
  }
}
