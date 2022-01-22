import 'package:coding_contest_tracker/pages/drawer_page/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloperPage extends StatelessWidget {
  static const routeName = "about-developer-page";
  final Function onBack;
  const AboutDeveloperPage({Key? key,required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String about = '''
    
## Hi 👋, I'm Akash Lilhare

I am from Rajnandgaon, India. A place of beauty and nature. Since my childhood. I love art and design. I always try to design stuff from my unique point of view. I also love to create things that can be useful to others.
# 
I started coding since I was in high school. Coding is also an art for me. I love it and now I have the opportunity to design along with the coding. I find it interesting and I enjoyed the process lot.
# 
My vision is to make the world a better place. Now almost everything is becoming better than ever. It is time for us to create more good stuff that helps the world to become a better place.

   ''';

    void launchURL(url) async => await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';

    List<SocialProfile> socialProfile = [
      SocialProfile(
          icon: FontAwesomeIcons.linkedin,
          title: "LinkedIn",
          color: Color(0xff0e76a8),
          onTap: () =>
              launchURL("https://www.linkedin.com/in/akash-lilhare-739a80192")),
      SocialProfile(
          icon: FontAwesomeIcons.github,
          title: "Github",
          color: Colors.green,
          onTap: () => launchURL("https://github.com/akashlilhare")),
      SocialProfile(
          icon: FontAwesomeIcons.googlePlay,
          title: "Play Store",
          color: Color(0xff689F38),
          onTap: () => launchURL(
              "https://play.google.com/store/apps/details?id=com.akash.lilhare")),
      SocialProfile(
        icon: FontAwesomeIcons.envelope,
        title: "Email",
        color: Colors.red,
        onTap: () => launchURL("mailto:${"akashlilhare14@gmail.com"}"),
      ),
      SocialProfile(
          icon: FontAwesomeIcons.twitter,
          title: "Twitter",
          color: Color(0xff24A4F2),
          onTap: () => launchURL("https://twitter.com/akash__lilhare")),
      SocialProfile(
          icon: FontAwesomeIcons.stackOverflow,
          title: "Stack Overflow",
          color: Color(0xffF1680B),
          onTap: () => launchURL(
              "https://stackoverflow.com/users/14102180/akash-lilhare"))
    ];

    buildSocial() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Social Profile",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Wrap(
              children: socialProfile
                  .map((profile) => Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: profile.color,elevation: 0),
                          onPressed: () => profile.onTap(),
                          label: Text(profile.title.toUpperCase()),
                          icon: FaIcon(profile.icon),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    }

    buildDivider() {
      return Container(
        height: 20,
        color: Colors.green.withOpacity(.1),
      );
    }

    buildThinDivider() {
      return Container(
        height: 2,
        color: Colors.green.withOpacity(.1),
      );
    }

    return WillPopScope(
      onWillPop: ()=>onBack(context),
      child: Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text("About Developer",),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Markdown(
                padding: EdgeInsets.symmetric(horizontal: 8),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                data: about,
                styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color!.withOpacity(.9),
                        letterSpacing: 1.5,
                        height: 1.5),
                    h2: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color
                    )),
              ),
              SizedBox(
                height: 18,
              ),
              buildDivider(),

              ListTile(
                onTap: (){
                  launchURL("https://play.google.com/store/apps/developer?id=Akash+Lilhare");
                },
                title: Text("View My Other Apps",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green,fontWeight: FontWeight.w600)),
              ),
              buildThinDivider(),
              ListTile(
                onTap: (){
                  launchURL("http://akash-lilhare.netlify.app");
                },
                title: Text("View my Website",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green,fontWeight: FontWeight.w600)),
              ),

              buildThinDivider(),

              buildDivider(),
              SizedBox(
                height: 18,
              ),
              buildSocial(),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialProfile {
  final IconData icon;
  final String title;
  final Color color;
  final Function onTap;

  SocialProfile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });
}
