import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/login/login_form.dart';
import 'package:han_bab/view/login/reset_pw.dart';
import 'package:han_bab/view/login/sign_up_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SingleChildScrollView: 키보드가 밀고올라와서 스크린 영역을 침범할때
      // 침범한 영역만큼 스크롤할 수 있게 하는 역할
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 100, 40, 100),
            child: Column(
              children: [
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/hanbab_icon.png'),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Theme(
                  // ThemeData 안에서 전체 정보입력 양식의 세부적인 디자인을 지정할 수 있음
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
                      ButtonTheme(
                        minWidth: 100,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                          onPressed: () {
                            Get.to(
                              () => LoginForm(),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/hgulogo.png',
                                    height: 25,
                                  ),
                                ),
                              ),
                              RichText(
                                  text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: '한동 이메일',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '로 로그인하기',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )),
                              Flexible(
                                child: Opacity(
                                  opacity: 0.0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: Image.asset(
                                      'assets/images/hgulogo.png',
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 구글로그인버튼
                      ButtonTheme(
                        minWidth: 100,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                          // 구글 로그인
                          onPressed: () {
                            authController.signInWithGoogle();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'assets/images/glogo.png',
                                  height: 40,
                                ),
                              ),
                              RichText(
                                  text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Google',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '로 간편 로그인하기',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )),
                              Flexible(
                                child: Opacity(
                                  opacity: 0.0,
                                  child: Image.asset('assets/images/glogo.png'),
                                ),
                              ),
                            ],
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
                                  color: Colors.grey,
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
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              child: const Text(
                                "비밀번호 재생성",
                                style: TextStyle(
                                  color: Colors.grey,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
