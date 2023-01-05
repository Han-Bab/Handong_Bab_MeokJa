import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:han_bab/screens/login/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // delay시간 때 스피너
  bool showSpinner = false;
  // validation 기능 구현을 위한 세 개의 string 변수
  String userPW = '';
  String userEmail = '';
  String userName = '';
  String userPhone = '';
  bool emailValidation = true;
  FocusNode emailFocusNode = FocusNode();

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원 가입"),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "한동 계정 이메일",
                    ),
                    // 이메일 입력 및 인증
                    Row(
                      children: [
                        // 한동 이메일 입력
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "이메일을 입력해주세요";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userEmail = value!;
                            },
                            onChanged: (value) {
                              userEmail = value;
                            },
                            focusNode: emailFocusNode,
                            onTap: () {},
                            decoration: InputDecoration(
                                hintText: "example@handong.ac.kr",
                                hintStyle: TextStyle(fontSize: 14),
                                errorText:
                                    emailValidation ? null : "한동 계정을 입력해주세요"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!_emailController.text!
                                .contains("@handong.ac.kr")) {
                              setState(() {
                                emailValidation = false;
                              });
                              // 작성한 글 다 select(drag) 하기
                              _emailController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: _emailController.text.length,
                              );
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);
                            } else {
                              setState(() {
                                emailValidation = true;
                              });
                            }
                            debugPrint(_emailController.text);
                            debugPrint("$emailValidation");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                          ),
                          child: const Text("인증"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [MaskedInputFormatter("000000")],
                            onTap: () {},
                            decoration: const InputDecoration(
                              hintText: "인증번호를 입력하세요",
                              hintStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                          ),
                          child: const Text("확인"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("비밀번호"),
                    TextFormField(
                      controller: _pwController,
                      validator: (value) {
                        if (value!.isEmpty || value!.length < 6) {
                          return "비밀번호는 최소 6자 이상 입력해주세요";
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (value) {
                        userPW = value!;
                      },
                      onChanged: (value) {
                        userPW = value;
                      },
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "비밀번호 확인",
                    ),
                    TextFormField(
                      controller: _pwConfirmController,
                      obscureText: true,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("이름"),
                    TextFormField(
                      onChanged: (value) {
                        userName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "이름을 입력해주세요";
                        }
                        return null;
                      },
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("전화번호"),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "전화번호를 입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userPhone = value;
                      },
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("개인정보 수집 이용 동의 넣어야함"),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("취소"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              _tryValidation();
                              setState(() {
                                showSpinner = true;
                              });

                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPW,
                                );
                                // newUser.user!.uid 는 특정 다큐먼트를 위한 식별자 역할
                                // set 메소드 내애서 원하는 엑스트라 데이터를 추가해줄 수 있다. 데이터는 항상 map 형태
                                // future 이면 await 붙이기
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(newUser.user!.uid)
                                    .set({
                                  'userEmail': userEmail,
                                  'userName': userName,
                                  'userPhone': userPhone,
                                });

                                if (newUser.user != null) {
                                  _authentication.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('$e'),
                                  backgroundColor: Colors.blue,
                                ));
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            child: const Text("가입"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
