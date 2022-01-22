import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageLoader extends StatelessWidget {
  const MainPageLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
