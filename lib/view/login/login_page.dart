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
                Center(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Image(
                          image: AssetImage('assets/hanbab.png'),
                        ),
                      ),
                      Text(
                        '서로의 뜻을 모아 모두가 행복한 시간\n한동 밥먹자에서 시작하세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          wordSpacing: 3,
                          height: 1.4,
                          color: Color.fromARGB(255, 116, 116, 116),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
                        child: Image(
                          image: AssetImage('assets/mainpage.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 90,
                // ),
                Theme(
                  // ThemeData 안에서 전체 정보입력 양식의 세부적인 디자인을 지정할 수 있음
                  data: ThemeData(
                    // form을 눌렀을 때 form의 색상
                    primaryColor: Colors.orange,
                    // textfield 위의 사용자에게 정보를 제공하는 텍스트을 꾸미기 위함
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.orange,
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
                        height: 100,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.orange),
                            padding: const EdgeInsets.all(8),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Get.to(
                              () => LoginForm(),
                              transition: Transition.fade,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/hgulogo.png',
                                  height: 20,
                                ),
                              ),
                              const Text(
                                "한동 이메일로 로그인하기",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
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
                        height: 100,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            side: const BorderSide(color: Colors.orange),
                            padding: const EdgeInsets.all(18),
                            elevation: 0,
                          ),
                          // 구글 로그인
                          onPressed: () {
                            authController.signInWithGoogle();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/googlelogo.png'),
                              const SizedBox(
                                width: 14,
                              ),
                              const Text(
                                '구글로 간편 로그인하기',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
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
                                  color: Color.fromARGB(255, 116, 116, 116),
                                ),
                              ),
                              onTap: () {
                                Get.to(
                                  () => const SignUpPage(),
                                  transition: Transition.fadeIn,
                                );
                              },
                            ),
                            const VerticalDivider(
                              thickness: 1,
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
                                Get.to(
                                  () => ResetPW(),
                                  transition: Transition.fadeIn,
                                );
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
