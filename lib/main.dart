import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/pages/about_developer_page.dart';
import 'package:coding_contest_tracker/pages/home_page/favorite_sites/favorite_sites_page.dart';
import 'package:coding_contest_tracker/pages/home_page/home_page.dart';
import 'package:coding_contest_tracker/pages/privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'data_provider/contest_provider.dart';
import 'data_provider/theme_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ContestProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => SavedContestProvider()),
        ],
        builder: (context, _) {
          return FutureBuilder<AdaptiveThemeMode>(
              future:
                  Provider.of<ThemeProvider>(context, listen: false).getTheme(),
              initialData: AdaptiveThemeMode.system,
              builder: (context, snapShot) {
                return AdaptiveTheme(
                  light: AppTheme().lightTheme,
                  dark: AppTheme().darkTheme,
                  initial: snapShot.hasData
                      ? snapShot.data ?? AdaptiveThemeMode.system
                      : AdaptiveThemeMode.system,
                  builder: (lightTheme, darkTheme) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Coding Contest Tracker',
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      home: const HomePage(
                        onBack: onBackPressed,
                      ),
                      routes: {
                        AboutDeveloperPage.routeName: (ctx) =>
                            const AboutDeveloperPage(onBack: onBackPressed),
                        HomePage.routeName: (ctx) =>
                            const HomePage(onBack: onBackPressed),
                        PrivacyPolicyPage.routeName: (ctx) =>
                            const PrivacyPolicyPage(onBack: onBackPressed),
                        FavoriteSitesPage.routName: (ctx)=> const FavoriteSitesPage(onBack : onBackPressed)
                      },
                    );
                  },
                );
              });
        });
  }
}

Future<bool> onBackPressed(BuildContext context) async {
  bool value = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))
              ),
              title: Text("Do you really want to exit the app?",style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
              actions: [
                ElevatedButton(

                  child: const Text("Yes"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                      primary: Theme.of(context).primaryColor.withOpacity(.5)),

                  onPressed: () => Navigator.pop(context, true),
                ),

                ElevatedButton(
                  child: const Text("No"),
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            );
          }) ??
      false;

  if (value) {
    SystemNavigator.pop();
    return true;
  } else {
    return false;
  }
}