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
            const Color.fromRGBO(225, 89, 89, 1).withOpacity(1),
            const Color.fromRGBO(255, 128, 16, 1).withOpacity(1),
          ],
          stops: const [
            0.3,
            1.0,
          ],
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