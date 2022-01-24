import 'package:coding_contest_tracker/data_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Column(
      children: [
        const Spacer(),
        Container(color: Colors.grey,height: .2,),
        Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              Consumer<ThemeProvider>(
                  builder: (context,data,_) {
                    return ToggleSwitch(
                      initialLabelIndex: data.switchIndex,
                      totalSwitches: 3,
                      minWidth: 95,
                      inactiveBgColor: Theme.of(context).primaryColor.withOpacity(.1),


                      icons: const [
                        FontAwesomeIcons.sun,
                        FontAwesomeIcons.moon,
                        FontAwesomeIcons.circle
                      ],

                      labels: const ['Light', 'Dark', 'System'],
                      onToggle: (index) {
                        data.setTheme(index: index, context: context);
                        Navigator.of(context).pop();
                      },
                    );
                  }
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "App Version : 1.0.7",
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.6)),
              ),

            ],
          ),
        ),

      ],
    );
  }
}
