import 'package:flutter/material.dart';
import 'package:han_bab/screens/main/profile_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "This is my First Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/page1.png"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Second Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/page2.png"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome",
          body: "This is my Third Page"
              '\nWe are making on-boarding screens'
              '\nIt is very interesting!',
          image: Image.asset("assets/page3.png"),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text("done"),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfilePage()),
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

PageDecoration getPageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.blue,
    ),
    imagePadding: EdgeInsets.only(top: 40),
    pageColor: Colors.orange,
  );
}
