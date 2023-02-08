import 'package:flutter/material.dart';
import 'package:han_bab/view/main/my_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TossIntroPage extends StatelessWidget {
  const TossIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "This is my First Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset(
            "/assets/images/page1.png",
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Second Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/images/page2.png"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Third Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/images/page3.png"),
          decoration: getPageDecoration(),
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
    );
  }
}
  PageDecoration getPageDecorationFull() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titlePadding: EdgeInsets.only(bottom: 10),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
      imagePadding: EdgeInsets.only(top: 70),
      imageFlex: 5,
      pageColor: Color(0xFF3268E8),
    );
  }
}
