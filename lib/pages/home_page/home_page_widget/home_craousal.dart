import 'package:carousel_slider/carousel_slider.dart';
import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarousel extends StatefulWidget {
  final ContestProvider data;

  const HomeCarousel({Key? key, required this.data}) : super(key: key);

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    buildContent({required Contest contest}) {
      String? duration = constants.getDuration(
        time: contest.duration,
      );
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Spacer(),
            Text(
              contest.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              "Start Time : " +
                  constants.getParsedTime(date: contest.startTime),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "End Time : " + constants.getParsedTime(date: contest.endTime),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            if (duration != null)
              Text(
                "Duration: " + duration,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            const Spacer(),
            ElevatedButton(
              child:const  Text(
                "View Contest",

                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(40, 40),
                  shape:const  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onPressed: () {
                constants.launchURL(url: contest.url);
              },
            ),
            const  Spacer(),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      );
    }

    buildSlider(ContestProvider data) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration:const  BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff614385), Color(0xff516395)],
              )),
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: data.runningContest.length,
                itemBuilder: (BuildContext context, int itemIndex, _) {
                  return buildContent(contest: data.runningContest[itemIndex]);
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
              bottom: 12,
              child: AnimatedSmoothIndicator(
                count: data.runningContest.length,
                effect: const WormEffect(
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
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Running Contest",
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        buildSlider(widget.data),
      ],
    );
  }
}
