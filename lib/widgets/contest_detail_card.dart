import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:coding_contest_tracker/widgets/bottom_meanu.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'countdown_timer.dart';

class ContestDetailCard extends StatelessWidget {
  final List<Color> colorList;
  final Contest contest;
  final String siteName;

  const ContestDetailCard(
      {Key? key,
      required this.contest,
      required this.colorList,
      required this.siteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    buildMoreButton() {
      return Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: (){
            showMaterialModalBottomSheet(
              context: context,
              elevation: 40,
              backgroundColor: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
              builder: (context) => BottomMenuPage(

                contest: contest,siteName: siteName,),
            );
          },
          borderRadius:const  BorderRadius.only(
              bottomRight: Radius.circular(16), topLeft: Radius.circular(8)),
          child: Container(
            padding:const  EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 4,
                    offset: const Offset(-2, -1), // Shadow position
                  ),
                ],
                color: Colors.white,
                borderRadius:const  BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(8))),
           child: const Icon(Icons.more_vert),
          ),
        ),
      );
    }

    Constants constants = Constants();
    return Container(
      margin: const EdgeInsets.only(
        top: 12,
        left: 8,
        right: 8,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius:const  BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: colorList)),
      child: Stack(
        children: [
          Column(
            children: [
              ContestCardHeader(
                endTime: contest.endTime,
                siteName: siteName,
                colors: colorList,
                status: contest.status,
                startTime: contest.startTime,
              ),
              Container(
                color: Colors.white.withOpacity(.4),
                height: .5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    Text(
                      contest.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Start Time : " +
                          constants.getParsedTime(date: contest.startTime),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "End Time : " +
                          constants.getParsedTime(date: contest.endTime),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    if (contest.duration != null)
                      Text(
                        "Duration: " +
                            constants
                                .getDuration(time: contest.duration)
                                .toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      child: const Text(
                        "View Contest",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize:const  Size(0, 40),
                        shape:const  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        constants.launchURL(url: contest.url);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          buildMoreButton(),
        ],
      ),
    );
  }
}
