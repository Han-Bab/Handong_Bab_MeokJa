import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/reset_pw.dart';
import 'package:han_bab/view/login/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // textfield에 입력한 내용을 관리하기 위함
    final TextEditingController idController = TextEditingController();
    final TextEditingController pwController = TextEditingController();
    Map userInfo = {
      'userEmail': '',
      'userPW': '',
    };

    void tryValidation() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "이메일 로그인",
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 이메일 입력폼
                      TextFormField(
                        controller: idController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains("@handong.ac.kr")) {
                            return "한동 이메일을 입력해주세요";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          userInfo['userEmail'] = value;
                        },
                        decoration: InputDecoration(
                          hintText: '한동이메일을 입력하세요',
                          labelStyle:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          hintStyle:
                              Theme.of(context).inputDecorationTheme.hintStyle,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // 비번 입력폼
                      TextFormField(
                        controller: pwController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "비밀번호는 최소 6자 이상 입력해주세요";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          userInfo['userPW'] = value;
                        },
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요',
                          labelStyle:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          hintStyle:
                              Theme.of(context).inputDecorationTheme.hintStyle,
                        ),
                        keyboardType: TextInputType.text,
                        // 보안을 위해 화면에 문자를 표시하지 않게 하기 위함
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: width,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // 로그인 버튼 기능 구현
                            tryValidation();
                            authController.login(userInfo);
                          },
                          child: const Text(
                            "로그인",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: const Text(
                                "이메일 회원가입",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 116, 116, 116),
                                ),
                              ),
                              onTap: () {
                                Get.to(() => const SignUpPage(),
                                    transition: Transition.downToUp,
                                    duration:
                                        const Duration(milliseconds: 800));
                              },
                            ),
                            const VerticalDivider(
                              thickness: 0.8,
                              color: Color.fromARGB(255, 116, 116, 116),
                            ),
                            GestureDetector(
                              child: const Text(
                                "비밀번호 재생성",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 116, 116, 116),
                                ),
                              ),
                              onTap: () {
                                Get.to(() => ResetPW(),
                                    transition: Transition.downToUp,
                                    duration:
                                        const Duration(milliseconds: 800));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
