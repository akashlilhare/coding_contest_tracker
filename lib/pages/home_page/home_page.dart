
import 'package:coding_contest_tracker/data_provider/contest_provider.dart';

import 'package:coding_contest_tracker/widgets/contest_page_loading.dart';
import 'package:coding_contest_tracker/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../drawer_page/drawer_page.dart';
import 'home_page_widget/home_craousal.dart';
import 'home_page_widget/home_page_body.dart';

class HomePage extends StatefulWidget {
  static const routeName = "Home-Page";
  final  onBack;
  const HomePage({Key? key,required this.onBack}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ContestProvider>(context, listen: false).setData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop:()=> widget.onBack(context),
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text(
            "Coding Contest Tracker",
          ),
        ),
        body: Consumer<ContestProvider>(builder: (context, data, _) {
          if (data.connectionStatus == DataConnectionStatus.loading) {
            return MainPageLoader();
          } else if (data.connectionStatus == DataConnectionStatus.success) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  HomeCarousel(data : data),
                  SizedBox(
                    height: 20,
                  ),
                  HomePageBody(),

                ],
              ),
            );
          } else {
            return ErrorPage(
              onRetry: () {
                Provider.of<ContestProvider>(context, listen: false).setData();
              },
            );
          }
        }),
      ),
    );
  }
}
