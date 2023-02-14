import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';

class ResetPW extends StatelessWidget {
  ResetPW({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String emailAddr = '';
    String emailUserName = '';
    String name = '';

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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF2F2F5),
                    border: InputBorder.none,
                    hintText: '한동 이메일을 입력해주세요',
                    hintStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    tryValidation();
                    authController.resetPassword(emailAddr);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                  ),
                  child: const Text(
                    "재설정 메일 보내기",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
