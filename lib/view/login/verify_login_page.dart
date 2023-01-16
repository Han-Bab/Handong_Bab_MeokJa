import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:han_bab/view/login/login_page.dart';

class VerifyLoginPage extends StatefulWidget {
  const VerifyLoginPage({Key? key}) : super(key: key);

  @override
  State<VerifyLoginPage> createState() => _VerifyLoginPageState();
}

class _VerifyLoginPageState extends State<VerifyLoginPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 이메일 인증 여부를 먼저 확인
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    // 만약 인증이 되어있지 않은 경우 인증 메일을 보낸다
    if (!isEmailVerified) {
      sendVerificationEmail();
      // 매 3초마다 인증버튼을 눌렀는지 확인
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  // timer가 작동하지 않을 때는 작동을 멈춰주는 기능
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // email이 인증되었는지 확인하는 메소드
  Future checkEmailVerified() async {
    // 매번 currentUser 의 정보를 reload 하고 확인
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      // 계속 인증코드를 다시 보낼 수 없으므로 보낼 수 있는 텀을 줌
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return LoginPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Verify Email"),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "입력하신 계정으로 인증 메일을 보냈습니다.",
                  style: TextStyle(fontSize: 24),
                ),
                const Text(
                  "계정을 인증해주세요",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 28,
                      ),
                      label: const Text(
                        '취소하기',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton.icon(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      icon: const Icon(
                        CupertinoIcons.mail_solid,
                      ),
                      label: const Text(
                        "인증코드 재전송",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
