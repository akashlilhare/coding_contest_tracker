import 'package:coding_contest_tracker/constants/constatns.dart';
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
                title: allContestList[index].title,
                src: allContestList[index].key,

              )));
        },
        child: Container(

          height: 100,
          margin: const EdgeInsets.only(bottom: 12),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                allContestList[index].title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius:const  BorderRadius.all(Radius.circular(12)),
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
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
            itemCount: allContestList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCard(index: index);
            })
      ],
    );
  }
}
