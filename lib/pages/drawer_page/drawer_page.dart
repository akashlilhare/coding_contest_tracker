import 'package:coding_contest_tracker/pages/drawer_page/pages/about_developer_page.dart';
import 'package:flutter/material.dart';

import '../main_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.red,
      child: Drawer(

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 60, left: 16),
                height: 140,
                width: double.infinity,
                child: Text("CC Tracker".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
                color: Colors.green,
              ),
              ListTile(
                title: Text("Home",style:TextStyle(color: Colors.white),),
onTap:()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  return MainPage();
})),
              ),
              ListTile(
                title: Text("Running Contest",style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text("Upcoming Contest",style:TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text("Share My App",style:TextStyle(color: Colors.white),),
              ),
              ListTile(
                title: Text("Rate My App",style:TextStyle(color: Colors.white),),
              ),
              ListTile(
                onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AboutDeveloperPage())),
                title: Text("About Developer",style:TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
