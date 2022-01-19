import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'data_provider/contest_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context) => ContestProvider()),
        ChangeNotifierProvider(create: (context) => SavedContestProvider()),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coding Contest Tracker',

        theme: AppTheme().darkTheme,
        home: MainPage(),
      ),
    );
  }
}
