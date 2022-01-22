import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/main.dart';
import 'package:coding_contest_tracker/model/contest_source_model.dart';
import 'package:flutter/material.dart';

import '../../platform_detail_page.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    buildCard({required int index}) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => PlatformContestDetailPage(
                title: allProvider[index].title,
                src: allProvider[index].key,

              )));
        },
        child: Container(

          height: 100,
          margin: EdgeInsets.only(bottom: 12),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(
              //   child: Opacity(
              //   opacity: .2,
              //   child: Image.asset(allProvider[index].imgSrc,height: 100,width: double.infinity,fit: BoxFit.cover,),),
              // ),
              Text(
                allProvider[index].title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                  begin: index % 2 == 0? Alignment.bottomLeft: Alignment.topRight,
                  end:index % 2 == 0? Alignment.bottomRight: Alignment.topRight,
                  colors: Constants().getGradients(cid: index))),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Contest",
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        ),
        ListView.builder(
            itemCount: allProvider.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCard(index: index);
            })
      ],
    );
  }
}
