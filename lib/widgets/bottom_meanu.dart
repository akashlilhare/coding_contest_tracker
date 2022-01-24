import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:coding_contest_tracker/constants/constatns.dart';
import 'package:coding_contest_tracker/model/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class BottomMenuPage extends StatelessWidget {
  final Contest contest;
  final String siteName;

  const BottomMenuPage(
      {Key? key, required this.contest, required this.siteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(color: Theme.of(context).textTheme.bodyText1!.color);
    var subTitleStyle = TextStyle(color: Theme.of(context).textTheme.bodyText2!.color);
    Constants constants = Constants();
    void addToCalender() {
      final Event event = Event(
        title: contest.name,
        description: "$siteName(${contest.url})",
        // location: "${contest.site}(${contest.url})",
        startDate: DateTime.parse(contest.startTime),
        endDate: DateTime.parse(contest.endTime),
      );

      Add2Calendar.addEvent2Cal(event);
    }

    void shareWithOther() {
      String text = '''
      
$siteName
${contest.name}
        
Start Time: ${constants.getParsedTime(date: contest.startTime)}
End Time: ${constants.getParsedTime(date: contest.endTime)}
        
${contest.url}
      ''';
      Share.share(text);
    }

    viewOnSite(){
      constants.launchURL(url: contest.url);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(siteName,maxLines: 1,overflow: TextOverflow.ellipsis, style: titleStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500,height: 2)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(contest.name,style: subTitleStyle,),
                const   SizedBox(height: 2,),
                Text("Start time: ${constants.getParsedTime(date: contest.startTime)}",style: subTitleStyle,),
                const SizedBox(height: 8,)
              ],
            ),
            isThreeLine: true,
          ),
          constants.buildThinDivider(),
          ListTile(
            onTap: addToCalender,
            leading: FaIcon(FontAwesomeIcons.calendarAlt,color: Theme.of(context).textTheme.bodyText2!.color,),
            title: Text("Save to calender",style: titleStyle,),
          ),
          constants.buildThinDivider(),
          ListTile(
            onTap: shareWithOther,
            leading: Icon(Icons.share,color: Theme.of(context).textTheme.bodyText2!.color,),
            title: Text("Share with friends",style: titleStyle,),
          ),
          constants.buildThinDivider(),
          ListTile(
            onTap: viewOnSite,
            leading: FaIcon(FontAwesomeIcons.externalLinkAlt,color: Theme.of(context).textTheme.bodyText2!.color,),
            title: Text("View contest Website",style: titleStyle,),
          ),
        ],
      ),
    );
  }
}
