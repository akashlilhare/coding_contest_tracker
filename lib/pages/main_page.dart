import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'contest_detail_page.dart';
import 'drawer_page/drawer_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int activeIndex = 0;

  List<List<Color>> colors = [
    [Colors.red, Colors.purple],
    [Colors.blue, Colors.green],
    [Colors.orange, Colors.green],
    [Colors.amber, Colors.blueGrey]
  ];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ContestProvider>(context, listen: false).setData();
      // Add Your Code here.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    buildContent({required Contest contest}) {
      String? duration = constants.getDuration(
          startTime: contest.startTime, endTime: contest.endTime);
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              contest.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Start Time : " +
                  constants.getParsedTime(date: contest.startTime),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "End Time : " + constants.getParsedTime(date: contest.endTime),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            if (duration != null)
              Text(
                "Duration: " + duration,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            Spacer(
              flex: 3,
            ),
            ElevatedButton(
              child: Text(
                "View Contest",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onPressed: () {
                constants.launchURL(url: contest.url);
              },
            ),
            Spacer(
              flex: 3,
            ),
            SizedBox(
              height: 4,
            )
          ],
        ),
      );
    }

    buildSlider() {
      return Consumer<ContestProvider>(builder: (context, data, _) {
        return data.connectionStatus == ConnectionStatus.loading
            ? CircularProgressIndicator()
            : ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.green, Colors.deepOrangeAccent])),
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: data.runningContest.length,
                        itemBuilder: (BuildContext context, int itemIndex, _) {
                          return buildContent(
                              contest: data.runningContest[itemIndex]);
                        },
                        options: CarouselOptions(
                            initialPage: 0,
                            viewportFraction: 1,
                            onPageChanged: (index, _) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      child: AnimatedSmoothIndicator(
                        count: data.runningContest.length,
                        effect: WormEffect(
                          dotHeight: 7,
                          paintStyle: PaintingStyle.stroke,
                          dotWidth: 7,
                          dotColor: Colors.white,
                          strokeWidth: 1,
                          activeDotColor: Colors.white,
                        ),
                        // your preferred effect
                        activeIndex: activeIndex,
                      ),
                    )
                  ],
                ),
              );
      });
    }

    buildCard({required int index}) {
      var rng = new Random();
      int cid = rng.nextInt(4);
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => ContestDetailPage(
                    title: allProvider[index].title,
                    src: allProvider[index].key,
                  )));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: ListTile(
            leading: Image.asset(allProvider[index].imgSrc),
            title: Text(
              allProvider[index].title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green, Colors.green])),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text(
          "Coding Contest Tracker",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              "Running Contest",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 12,
            ),
            buildSlider(),
            SizedBox(
              height: 20,
            ),
            Text(
              "All Contest",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 12,
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4),
                itemCount: allProvider.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildCard(index: index);
                })
          ],
        ),
      ),
    );
  }
}
