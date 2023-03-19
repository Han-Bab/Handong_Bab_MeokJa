import 'package:flutter/material.dart'; //안드로이드 디자인
//IOS 디자인홈 화면 함수 불러오기 불러오기
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/login_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
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
    // MARK: implement initState
    super.initState();
    initialization();
    initializeDateFormatting("ko", null);
  }

  void initialization() async {
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      builder: FToastBuilder(),
      theme: ThemeData(
        fontFamily: 'fonts',
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
        splashColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          color: Colors.orange,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.orange[300],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: false,
          border: UnderlineInputBorder(),
          hintStyle: TextStyle(
            color: Color(0xFFC2C2C2),
            fontSize: 14,
          ),
        ),
      ),

      //themeMode: ThemeMode.system,
    );
  }
}
