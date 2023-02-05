import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../mypage/onboarding_page.dart';

class KakaoIntroPage extends StatelessWidget {
  const KakaoIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "카카오톡 접속",
            body: "카카오톡에 접속 후 하단의 5개의 버튼 중"
                "\n가장 오른쪽 버튼을 눌러 더보기란으로 이동하고"
                "\n우측 상단 버튼을 클릭합니다.",
            image: Image.asset("assets/images/카카오온보딩1.png"),
            decoration: getPageDecorationCut()),
        PageViewModel(
            title: "송금코드 생성",
            body: "코드를 스캔하는 카메라가 뜨는 화면에서"
                "\n하단의 '송금코드' 버튼을 클릭합니다.",
            image: Image.asset("assets/images/카카오온보딩2.png"),
            decoration: getPageDecorationCut()),
        PageViewModel(
            title: "링크 복사",
            body: "위의 화면에서 표시된 버튼을 눌러"
                "\n카카오 송금 링크를 복사하면 끝!",
            image: Image.asset("assets/images/카카오온보딩3.png"),
            decoration: getPageDecorationFull()),
      ],
      done: const Text(
        "done",
        style: TextStyle(color: Colors.orangeAccent),
      ),
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage()),
        );
      },
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.orangeAccent,
      ),
      skip: const Text(
        "Skip",
        style: TextStyle(color: Colors.orangeAccent),
      ),
      showSkipButton: true,
      dotsDecorator: DotsDecorator(
        color: Colors.amberAccent,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: Colors.orangeAccent,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      curve: Curves.bounceOut,
    );
  }

  PageDecoration getPageDecorationFull() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titlePadding: EdgeInsets.only(bottom: 10),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      imagePadding: EdgeInsets.only(top: 70),
      imageFlex: 5,
      pageColor: Color(0xFFFFEB03),
    );
  }

  PageDecoration getPageDecorationCut() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titlePadding: EdgeInsets.only(top: 20, bottom: 10),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      imagePadding: EdgeInsets.only(top: 200),
      imageFlex: 3,
      pageColor: Color(0xFFFFEB03),
    );
  }
}
