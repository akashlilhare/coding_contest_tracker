import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error",
          style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
