import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/data_provider/saved_contest_provider.dart';
import 'package:coding_contest_tracker/pages/drawer_page/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../platform_detail_page.dart';
import 'favorite_filter.dart';

class FavoriteSitesPage extends StatefulWidget {
  static const routName = "favorite-site-page";
  final Function onBack;

  const FavoriteSitesPage({Key? key, required this.onBack}) : super(key: key);

  @override
  State<FavoriteSitesPage> createState() => _FavoriteSitesPageState();
}

class _FavoriteSitesPageState extends State<FavoriteSitesPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      Provider.of<SavedContestProvider>(context, listen: false).getSelectedSites();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => widget.onBack(context),
      child: Consumer<SavedContestProvider>(builder: (context, data, _) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Favorite Sites"),

              ),
              drawer: const DrawerPage(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                    data.selectedContestList.isEmpty?
                    Icons.add :Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ContestFilterPage();
                      });
                },
              ),
              body:data.selectedContestList.isEmpty?const Padding(
                padding:  EdgeInsets.all(28.0),
                child: Center(child: Text("No sites selected to favorite list",style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
              ): SingleChildScrollView(

                padding: const EdgeInsets.only(bottom: 8,top: 4),
                physics: const BouncingScrollPhysics(),
                child:  Column(
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 1),
                          itemCount: data.selectedContestList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => PlatformContestDetailPage(
                                          title: data.selectedContestList[index].title,
                                          src: data.selectedContestList[index].key,
                                        )));
                              },
                              child: Container(
padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data.selectedContestList[index].title,
                                       textAlign: TextAlign.center, style: const TextStyle(

                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                    gradient: LinearGradient(
                                        begin: index % 2 == 0
                                            ? Alignment.bottomLeft
                                            : Alignment.topRight,
                                        end: index % 2 == 0
                                            ? Alignment.bottomRight
                                            : Alignment.topRight,
                                        colors:
                                            Constants().getGradients(cid: index))),
                              ),
                            );
                          })
                    ],
                  )

              ));
        }
      ),
    );
  }
}
