import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:han_bab/view/onboarding/kakao_intro_page.dart';
import 'package:han_bab/view/onboarding/toss_intro_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      print("logout");
                      GoogleSignIn().signOut();
                      _authentication.signOut();
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "카카오 온보딩",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      print("카카오");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KakaoIntroPage()));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "토스 온보딩",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      print("토스");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TossIntroPage()));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '토스트 테스트',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
