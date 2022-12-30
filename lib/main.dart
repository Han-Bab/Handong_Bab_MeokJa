import 'package:flutter/material.dart'; //안드로이드 디자인
import 'package:flutter/cupertino.dart'; //IOS 디자인홈 화면 함수 불러오기
import 'loading/splash_screen.dart'; //로딩 함수 불러오기
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:han_bab/screens/login/login_page.dart';
import 'package:han_bab/screens/main/main_screen.dart';
import 'firebase_options.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
