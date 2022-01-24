import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
        insetPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Theme.of(context).cardColor,
              elevation: 1,

              child: Row(
                children: [
                  const Padding(
                    padding:
                     EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
                    child: Text(
                      "Select Contests",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  CloseButton(color: Theme.of(context).textTheme.bodyText2!.color,),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: Wrap(
                children: data.savedContestList.map((contest) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: FilterChip(
                        selected: contest.isSelected,
                        backgroundColor: Colors.green.shade100.withOpacity(.25),
                        elevation: 0,
                        selectedColor: Theme.of(context).primaryColor.withOpacity(.8),
                        showCheckmark: false,
                        labelStyle: TextStyle(
                            color: contest.isSelected
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                        label: Text(contest.title),
                        onSelected: (val) {
                          data.toggleFilter(contest: contest,value: val);
                        }),
                  );
                })
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: const Size(140,40),
                    ),
                    child: const Text("APPLY"),

                    onPressed: () {

                      data.saveData(list: data.savedContestList);

                      data.getSelectedSites();
                      Navigator.of(context).pop();

                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    });
  }
}