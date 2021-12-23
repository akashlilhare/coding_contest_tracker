import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:coding_contest_tracker/pages/contest_filter_page.dart';
import 'package:coding_contest_tracker/widgets/error_page.dart';
import 'package:coding_contest_tracker/widgets/loading_srceen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  void initState() {
     Provider.of<ContestProvider>(context, listen: false).readContestData( tag: "all");
    Provider.of<SavedContestProvider>(context, listen: false).readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readData({required int index}) {
      List<ContestSource> list = Provider
          .of<SavedContestProvider>(context, listen: false)
          .contestProviderList;
      Provider.of<ContestProvider>(context, listen: false).readContestData(
          tag: list[index].key);
    }
    List<ContestSource> contestProviderList = Provider
        .of<SavedContestProvider>(context, listen: false)
        .contestProviderList;
    return
      DefaultTabController(
        length: contestProviderList.length,

        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ContestFilterPage();
                    });
              },
            ),
            appBar: AppBar(
              title: Text("CC List"),
              bottom: TabBar(
                isScrollable: true,
                onTap: (int index) {
                  readData(index: index);
                },
                tabs: contestProviderList.map((e) => Tab(child: Text(e.title)))
                    .toList(),
              ),
            ),

            body: TabBarView(
                children: contestProviderList.map((e) =>
                    Consumer<ContestProvider>(builder: (context, data, _) {
                      return data.connectionStatus == ConnectionStatus.loading
                          ? LoadingScreen()
                          : data.connectionStatus == ConnectionStatus.error
                          ? ErrorPage()
                          : SingleChildScrollView(
                        child: Column(
                          children: data.contestList
                              .map((contest) =>
                              ListTile(
                                title: Text(contest.name),
                              ))
                              .toList(),
                        ),
                      );
                    })).toList()
            )
        ),
      );
  }
}
