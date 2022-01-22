import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainPageLoader extends StatelessWidget {
  const MainPageLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color darkColor = Theme.of(context).cardColor;

    buildHeaderCard({required double height}) {
      return Container(
        height: height,
        decoration: BoxDecoration(
            color: isDark ? darkColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
      );
    }

    buildVerticalCard() {
      buildCard() {
        return Container(
          height: height * .15,
          width: width / 3.5,
          decoration: BoxDecoration(
              color: isDark ? darkColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCard(),
          buildCard(),
          buildCard(),
        ],
      );
    }

    buildArtistCard() {
      return Column(
        children: [
          buildHeaderCard(height: height * .15),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? darkColor : Colors.grey.shade200,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: isDark ? darkColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ))
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Coding Contest Tracker"),
      ),
      body: Shimmer.fromColors(
        baseColor: isDark ? darkColor : Colors.grey.shade200,
        highlightColor:
        isDark ? Colors.blueGrey.shade800 : Colors.grey.shade100,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildHeaderCard(height: height * .3),
                const SizedBox(
                  height: 30,
                ),
                buildVerticalCard(),
                const SizedBox(
                  height: 50,
                ),
                buildVerticalCard(),
                const SizedBox(
                  height: 10,
                ),
                buildVerticalCard(),
                const SizedBox(
                  height: 30,
                ),
                //   buildHeaderCard(height: height * .2),
                const SizedBox(
                  height: 30,
                ),
                buildArtistCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
