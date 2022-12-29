import 'package:flutter/material.dart'; //안드로이드 디자인
import 'package:flutter/cupertino.dart'; //IOS 디자인
import 'home/home_screen.dart'; //홈 화면 함수 불러오기
import 'loading/splash_screen.dart'; //로딩 함수 불러오기

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Future.delayed(Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 900),  //페이드인아웃 효과
            child: _splashLodingWidget(snapshot),   //스냅샷실행 위젯지정
          );
        }
    );
  }
  StatelessWidget _splashLodingWidget(AsyncSnapshot<Object> snapshot) {
    if(snapshot.hasError) {print('에러가 발생하였습니다.'); return Text('Error');} //에러발생
    else if(snapshot.hasData) {return HomeScreen();} //정상
    else{return SplashScreen();} //그외
  }
}
