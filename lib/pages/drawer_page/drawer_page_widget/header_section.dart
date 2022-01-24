import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 90,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("CC Tracker".toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ),
      color: Colors.green,
    );
  }
}
