import 'package:flutter/material.dart'; //안드로이드 디자인
import 'package:flutter/cupertino.dart'; //IOS 디자인홈 화면 함수 불러오기 불러오기
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/login_page.dart';
import 'package:han_bab/view/login/verify_login_page.dart';
import 'package:han_bab/view/main/main_screen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  KakaoSdk.init(nativeAppKey: '7a0fe1780f619b2dccaea7d4ddbaea70');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    print("initialized...");
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
    );
  }
}
