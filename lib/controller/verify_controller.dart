import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  static VerifyController instance = Get.find();

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      // 매 3초마다 인증버튼을 눌렀는지 확인
      _timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // 매번 currentUser 의 정보를 reload 하고 확인
    await FirebaseAuth.instance.currentUser!.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified) {
      _timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      // 계속 인증코드를 다시 보낼 수 없으므로 보낼 수 있는 텀을 줌
      canResendEmail = false;

      await Future.delayed(Duration(seconds: 5));
      canResendEmail = true;
    } catch (e) {
      print(e);
      Get.snackbar('error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
}
