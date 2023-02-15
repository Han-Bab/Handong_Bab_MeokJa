import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      Get.snackbar('인증 완료', '인증 확인되었습니다\n다시 로그인해주세요',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white);
      return LoginPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "한동 이메일 인증",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "인증 메일을 전송했습니다.",
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "본인 계정을 인증해주세요.",
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: verifyController.canResendEmail
                            ? verifyController.sendVerificationEmail
                            : null,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              CupertinoIcons.mail_solid,
                              size: 24,
                            ),
                            Text(
                              "인증코드 재전송",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Opacity(
                              opacity: 0,
                              child: Icon(
                                CupertinoIcons.mail_solid,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.cancel,
                              size: 24,
                            ),
                            Text(
                              '취소하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Opacity(
                              opacity: 0,
                              child: Icon(
                                Icons.cancel,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 124,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
