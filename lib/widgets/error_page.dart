import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Function onRetry;
  const ErrorPage({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: .7,
            child: Image.asset(
              "assets/error_page/no_result_found.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.08,
            // left: MediaQuery.of(context).size.width * 0.065,
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                elevation: 1,
                primary:  Colors.white,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              ),


              onPressed: () {onRetry();},
              child: Text("Retry".toUpperCase(),style: const TextStyle(color: Colors.black),),
            ),
          )
        ],
      );
  }
}
