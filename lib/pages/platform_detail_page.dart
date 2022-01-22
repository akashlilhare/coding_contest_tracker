import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/widgets/contest_detail_card.dart';
import 'package:coding_contest_tracker/widgets/contest_page_loading.dart';
import 'package:coding_contest_tracker/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PlatformContestDetailPage extends StatefulWidget {
  final String title;
  final String src;


  const PlatformContestDetailPage(
      {Key? key, required this.title, required this.src})
      : super(key: key);

  @override
  _PlatformContestDetailPageState createState() =>
      _PlatformContestDetailPageState();
}

class _PlatformContestDetailPageState extends State<PlatformContestDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ContestProvider>(context, listen: false)
          .readPlatformContest(tag: widget.src);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Consumer<ContestProvider>(builder: (context, data, _) {

      bool isDark =
          MediaQuery.of(context).platformBrightness == Brightness.dark;

          return Scaffold(
            appBar: AppBar(
              title:data.connectionStatus == DataConnectionStatus.loading ? Shimmer.fromColors(
                baseColor: isDark ? Colors.green.withOpacity(.1) : Colors.grey.shade200,

                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 120,
                      decoration: BoxDecoration(
                          color: isDark
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                          color: isDark
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              )
                  :  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title),
                  SizedBox(height: 1,),
                  Text(data.platformContestList.length.toString() +" Contest",style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color!.withOpacity(.6),
                    fontSize: 14
                  ),)
                ],
              ),
            ),
            body:data.connectionStatus == DataConnectionStatus.loading
                ? MainPageLoader()
                : data.connectionStatus == DataConnectionStatus.error
                ? ErrorPage(
              onRetry: () {
                Provider.of<ContestProvider>(context, listen: false)
                    .readPlatformContest(tag: widget.src);
              },
            )
                : data.platformContestList.isEmpty?Center(child: Text("No Contest Found For\n${widget.title} ",textAlign: TextAlign.center,),):  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 4,bottom: 16),
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.platformContestList.length,
                      itemBuilder: (context,index){

                    return  ContestDetailCard(contest: data.platformContestList[index] ,colorList:Constants().getGradients(cid: index),);
                  })
                ],
              )
            ),
          );
        });
  }
}
