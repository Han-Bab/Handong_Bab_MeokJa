import 'package:flutter/material.dart';
import 'package:han_bab/screens/login/sign_up_page.dart';
import 'package:han_bab/screens/main/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // textfield에 입력한 내용을 관리하기 위함
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "한동 밥 묵자",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      // SingleChildScrollView: 키보드가 밀고올라와서 스크린 영역을 침범할때
      // 침범한 영역만큼 스크롤할 수 있게 하는 역할
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Center(
                child: Image(
                  image: const AssetImage('assets/images/chef.gif'),
                  width: width * 0.7,
                ),
              ),
              Form(
                child: Theme(
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
                      )),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    // 아이콘들을 세로로 지정하기 위함
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _idController,
                          decoration: InputDecoration(
                            hintText: '아이디를 입력하세요',
                            labelStyle: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle,
                            hintStyle: Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          controller: _pwController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: 100,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_idController.text == 'admin' &&
                                  _pwController.text == '1234') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );
                              } else if (_idController.text == 'admin' &&
                                  _pwController.text != '1234') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('비밀번호를 잘못 입력하셨습니다.'),
                                  duration: Duration(seconds: 3),
                                ));
                              } else if (_idController.text != 'admin' &&
                                  _pwController.text == '1234') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('아이디를 잘못 입력하셨습니다.'),
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('정보를 잘못 입력하셨습니다.'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                            ),
                            child: const Text("로그인"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Text("회원가입"),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                              },
                            ),
                            GestureDetector(
                              child: const Text("비밀번호 찾기"),
                              onTap: () {
                                debugPrint("비번찾기");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
