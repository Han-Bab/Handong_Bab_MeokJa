import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';

class ResetPW extends StatelessWidget {
  ResetPW({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String emailAddr = '';

    void tryValidation() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
        Get.snackbar(
          '전송 완료',
          '입력하신 이메일로 비밀전호 재설정 메일을 전송했습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          '전송 실패',
          '비밀전호 재설정 메일 전송을 실패했습니다',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: (value) {
                    emailAddr = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@handong.ac.kr")) {
                      return "한동 이메일을 입력해주세요";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    hintText: '가입한 한동 이메일 입력',
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                    contentPadding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        width: width,
        child: ElevatedButton(
          onPressed: () {
            tryValidation();
            authController.resetPassword(emailAddr);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
          ),
          child: const Text(
            "재설정 메일 보내기",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
