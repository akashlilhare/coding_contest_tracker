import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/data_provider/contest_provider.dart';
import 'package:coding_contest_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../about_developer_page.dart';
import '../../contest_detatil_page.dart';
import '../../home_page/home_page.dart';
import '../../privacy_policy_page.dart';

class DrawerItemSection extends StatelessWidget {
  const DrawerItemSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String url =
        "https://play.google.com/store/apps/details?id=com.akash.coding_contest_tracker";
    var provider = Provider.of<ContestProvider>(context, listen: false);
    var listTilePadding = EdgeInsets.only(left: 12, right: 8);
    var menuItemStyle =
        TextStyle(color: Theme.of(context).textTheme.headline1!.color);
    Constants constants = Constants();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ListTile(
            contentPadding: listTilePadding,
            title: Text(
              "Home",
              style: menuItemStyle,
            ),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomePage.routeName),
          ),
          constants.buildThinDivider(),
          ListTile(
            contentPadding: listTilePadding,
            title: Text(
              "All Contest",
              style: menuItemStyle,
            ),
            onTap: () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return ContestDetailPage(
                  onBack: onBackPressed,
                  title: "All Contest", contestList: provider.allContest);
            })),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  color: Colors.green),
              child: Text(
                provider.allContest.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          constants.buildThinDivider(),
          ListTile(
            contentPadding: listTilePadding,
            title: Text(
              "Running Contest",
              style: menuItemStyle,
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  color: Colors.orange),
              child: Text(
                provider.runningContest.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return ContestDetailPage(
                onBack: onBackPressed,
                  title: "Running Contest", contestList: provider.runningContest);
            })),
          ),
          constants.buildThinDivider(),
          ListTile(
            contentPadding: listTilePadding,
            title: Text(
              "Contests in next 24Hr",
              style: menuItemStyle,
            ),
            trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: Colors.red),
                child: Text(
                  provider.upcoming24Contest.length.toString(),
                  style: TextStyle(color: Colors.white),
                )),
            onTap: () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return ContestDetailPage(
                  onBack: onBackPressed,
                  title: "Contests in next 24Hr",
                  contestList: provider.upcoming24Contest);
            })),
          ),
          constants.buildThinDivider(),
          ListTile(
            onTap: () {
              Share.share('Track All Coding Contest with $url');
            },
            contentPadding: listTilePadding,
            title: Text(
              "Share My App",
              style: menuItemStyle,
            ),
          ),
          constants.buildThinDivider(),
          ListTile(
            onTap: () async {
              if (!await launch(url)) throw 'Could not launch $url';
            },
            contentPadding: listTilePadding,
            title: Text(
              "Rate My App",
              style: menuItemStyle,
            ),
          ),
          constants.buildThinDivider(),
          ListTile(
            contentPadding: listTilePadding,
            title: Text(
              "Privacy Policy",
              style: menuItemStyle,
            ),
            onTap: () => Navigator.pushReplacementNamed(
                context, PrivacyPolicyPage.routeName),
          ),
          constants.buildThinDivider(),
          ListTile(
            contentPadding: listTilePadding,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AboutDeveloperPage.routeName),
            title: Text(
              "About Developer",
              style: menuItemStyle,
            ),
          ),
          constants.buildThinDivider(),
        ],
      ),
    );
  }
}
