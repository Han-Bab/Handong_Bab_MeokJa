import 'package:flutter/material.dart';
import 'package:han_bab/view/main/my_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class KakaoIntroPage extends StatelessWidget {
  const KakaoIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "This is my First Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/images/page1.png"),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Second Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset(
            "assets/images/page2.png",
          ),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Third Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/images/page3.png"),
        ),
      ],
      done: const Text("done"),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyPage()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      skip: const Text("Skip"),
      showSkipButton: true,
      dotsDecorator: DotsDecorator(
        color: Colors.cyan,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      curve: Curves.bounceOut,
    );
  }
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
      titlePadding: EdgeInsets.only(bottom: 10),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      imagePadding: EdgeInsets.only(top: 200),
      imageFlex: 3,
      pageColor: Color(0xFFFFEB03),
    );
  }
