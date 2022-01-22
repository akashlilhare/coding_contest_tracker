import 'package:flutter/material.dart';

import 'drawer_page_widget/drawer_item_section.dart';
import 'drawer_page_widget/footer_section.dart';
import 'drawer_page_widget/header_section.dart';

class DrawerPage extends StatelessWidget {

  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [HeaderSection(), DrawerItemSection()],
              ),
            ),
            FooterSection()
          ],
        ),
      ),
    );
  }
}
