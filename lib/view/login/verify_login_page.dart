import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/verify_controller.dart';
import 'package:han_bab/view/login/login_page.dart';

class VerifyLoginPage extends StatelessWidget {
  const VerifyLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final verifyController = Get.put(VerifyController());

    double width = MediaQuery.of(context).size.width;
    if (verifyController.isEmailVerified) {
      showToast('인증 확인되었습니다. 다시 로그인해주세요');
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
                  "인증 메일을 보냈습니다.",
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  "계정을 인증해주세요",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: width * 0.7,
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 24,
                        ),
                        label: const Text(
                          '취소하기',
                          // style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton.icon(
                        onPressed: verifyController.canResendEmail
                            ? verifyController.sendVerificationEmail
                            : null,
                        icon: const Icon(
                          CupertinoIcons.mail_solid,
                          size: 24,
                        ),
                        label: const Text(
                          "인증코드 재전송",
                          // style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
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
