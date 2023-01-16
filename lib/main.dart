import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; //안드로이드 디자인
import 'package:flutter/cupertino.dart'; //IOS 디자인홈 화면 함수 불러오기 불러오기
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:han_bab/view/loading/splash_screen.dart';
import 'package:han_bab/view/login/login_page.dart';
import 'package:han_bab/view/login/verify_login_page.dart';
import 'package:han_bab/view/main/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () => 100),
        builder: (context, snapshot) {
          return MaterialApp(
            home: AnimatedSwitcher(
              duration: Duration(milliseconds: 900),
              child: _splashLoadingWidget(snapshot),
            ),
          );
        });
  }
}

StatefulWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
  final _authentication = FirebaseAuth.instance;

  if (snapshot.hasError) {
    debugPrint("에러 발생");
    return SplashScreen();
  } else if (snapshot.connectionState == ConnectionState.done) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            final userName = _authentication.currentUser!.displayName;
            showToast(userName);
            return MainScreen();
          } else {
            return VerifyLoginPage();
          }
        } else {
          return LoginPage();
        }
      },
    );
  } else {
    return SplashScreen();
  }
}

void showToast(String? userName) {
  Fluttertoast.showToast(
    msg: '$userName님, 환영합니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
