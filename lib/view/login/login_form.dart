import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // textfield에 입력한 내용을 관리하기 위함
    final TextEditingController _idController = TextEditingController();
    final TextEditingController _pwController = TextEditingController();
    Map userInfo = {
      'userEmail': '',
      'userPW': '',
    };

    void _tryValidation() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("이메일 로그인"),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 80),
              child: Column(
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/hanbab_icon.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Theme(
                      data: ThemeData(
                        // form을 눌렀을 때 form의 색상
                        primaryColor: Colors.teal,
                        // textfield 위의 사용자에게 정보를 제공하는 텍스트을 꾸미기 위함
                        inputDecorationTheme: const InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 이메일 입력폼
                          TextFormField(
                            controller: _idController,
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
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          // 비번 입력폼
                          TextFormField(
                            controller: _pwController,
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
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                            ),
                            keyboardType: TextInputType.text,
                            // 보안을 위해 화면에 문자를 표시하지 않게 하기 위함
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          width: width,
          height: 70,
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 24),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            onPressed: () {
              // 로그인 버튼 기능 구현
              _tryValidation();
              authController.login(userInfo);
            },
            child: const Text("로그인"),
          ),
        ),
      ),
    );
  }
}
