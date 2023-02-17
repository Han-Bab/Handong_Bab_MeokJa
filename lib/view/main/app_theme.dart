import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: defaultFirebaseAppName,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff000080),
        backgroundColor: Color(0xff000080),


      ),
    );
  }
}
