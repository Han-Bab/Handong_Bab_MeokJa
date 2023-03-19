import 'package:flutter/material.dart';

class CustomToolbarRect extends StatelessWidget {
  const CustomToolbarRect({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            const Color(0xffF97E13).withOpacity(1),
            const Color(0xffFDB670).withOpacity(1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // stops: const [
          //   0.5,
          //   0.8,
          // ]
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}