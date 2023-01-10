import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:han_bab/screens/login/sign_up_page.dart';
import 'package:han_bab/screens/login/verify_signup_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // 로그인 버튼 이후 딜레이 시간 스피너 지정
  bool showSpinner = false;
  // textfield에 입력한 내용을 관리하기 위함
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String userPW = '';
  String userEmail = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  final _authentication = FirebaseAuth.instance;

  // 구글 간편 로그인
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser!.email.contains('@handong.ac.kr')) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print("한동 계정임으로 로그인 성공");
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      print("한동 계정 아님으로 로그인 실패");
      showToast();
      return await FirebaseAuth.instance.signOut();
    }
  }

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
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
                  key: _formKey,
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
                          // 이메일 입력폼
                          TextFormField(
                            controller: _idController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value!.contains("@handong.ac.kr")) {
                                return "한동 이메일을 입력해주세요";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userEmail = value!;
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
                              if (value!.isEmpty || value!.length < 6) {
                                return "비밀번호는 최소 6자 이상 입력해주세요";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userPW = value!;
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
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonTheme(
                            minWidth: 100,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                // 로그인 버튼 누를 시 스피너 트루 지정
                                setState(() {
                                  showSpinner = true;
                                });
                                // 로그인 버튼 기능 구현
                                _tryValidation();
                                try {
                                  final currUser = await _authentication
                                      .signInWithEmailAndPassword(
                                    email: userEmail,
                                    password: userPW,
                                  );
                                  // Stream builder 를  설정해줌으로 인한 중복이동으로 주석처리
                                  // 이동 이후 스피너 false
                                  setState(() {
                                    showSpinner = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("$e")));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
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
                              ),
                              // 구글 로그인
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                });
                                signInWithGoogle();
                                setState(() {
                                  showSpinner = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Image.asset(
                                      'assets/images/glogo.png',
                                    ),
                                  ),
                                  const Text(
                                    'Login with Google',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                  ),
                                  Flexible(
                                    child: Opacity(
                                      opacity: 0.0,
                                      child: Image.asset(
                                          'assets/images/glogo.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // 회원가입 및 비번 찾기 버튼
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
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '한동 구글 계정만 로그인 가능합니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
