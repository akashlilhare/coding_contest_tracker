import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:coding_contest_tracker/widgets/contest_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'drawer_page/drawer_page.dart';

class ContestDetailPage extends StatefulWidget {
  final String title;
  final List<Contest> contestList;
  final Function onBack;

  const ContestDetailPage(
      {Key? key, required this.title, required this.contestList, required this.onBack})
      : super(key: key);

  @override
  State<ContestDetailPage> createState() => _ContestDetailPageState();
}

class _ContestDetailPageState extends State<ContestDetailPage> {
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000)).then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop:()=> widget.onBack(context),
      child: Scaffold(
          drawer: const DrawerPage(),
          appBar: AppBar(
            title:isLoading ? Shimmer.fromColors(
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
                const SizedBox(height: 1,),
                Text(widget.contestList.length.toString() +" Contest",style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color!.withOpacity(.6),
                    fontSize: 14
                ),)
              ],
            ),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                )
              : ListView.builder(

                  itemCount: widget.contestList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ContestDetailCard(
                      contest: widget.contestList[index],
                      colorList: Constants().getGradients(cid: index),
                      siteName: widget.contestList[index].site,
                    );
                  })),
    );
  }
}
