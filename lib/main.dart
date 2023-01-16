import 'package:flutter/material.dart'; //안드로이드 디자인
import 'package:flutter/cupertino.dart'; //IOS 디자인홈 화면 함수 불러오기 불러오기
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/login_page.dart';
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
    // });
  }
}

// StatefulWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
//   // final _authentication = FirebaseAuth.instance;
//
//   if (snapshot.hasError) {
//     debugPrint("에러 발생");
//     return SplashScreen();
//   } else if (snapshot.connectionState == ConnectionState.done) {
//     return LoginPage();
//     // return StreamBuilder(
//     //   stream: FirebaseAuth.instance.authStateChanges(),
//     //   builder: (context, snapshot) {
//     //     if (snapshot.hasData) {
//     //       if (FirebaseAuth.instance.currentUser!.emailVerified) {
//     //         final userName = _authentication.currentUser!.displayName;
//     //         showToast(userName);
//     //         return MainScreen();
//     //       } else {
//     //         return VerifyLoginPage();
//     //       }
//     //     } else {
//     //       return LoginPage();
//     //     }
//     //   },
//     // );
//   } else {
//     return SplashScreen();
//   }
// }

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
