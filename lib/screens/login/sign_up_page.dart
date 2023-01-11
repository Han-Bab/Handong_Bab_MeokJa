import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:han_bab/screens/login/account_term.dart';
import 'package:han_bab/screens/login/privacy_term.dart';
import 'package:han_bab/screens/login/verify_signup_page.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool validation = false;
  // delay시간 때 스피너
  bool showSpinner = false;
  // validation 기능 구현을 위한 세 개의 string 변수
  String userPW = '';
  String userEmail = '';
  String userName = '';
  String userPhone = '';
  FocusNode emailFocusNode = FocusNode();

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _visibility = false;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      if (_isChecked1 && _isChecked2) {
        setState(() {
          validation = true;
          _visibility = false;
        });
        _formKey.currentState!.save();
      } else {
        setState(() {
          validation = false;
          _visibility = true;
        });
      }
    }
    if (!isValid) {
      setState(() {
        validation = false;
      });
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "한동 계정 이메일",
                      ),
                    ),
                    // 한동 이메일 입력
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "이메일을 입력해주세요";
                        }
                        if (!value!.contains('@handong.ac.kr')) {
                          return "한동계정을 입력해주세요";
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
                      decoration: const InputDecoration(
                        hintText: "example@handong.ac.kr",
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "비밀번호 ",
                      ),
                    ),
                    // 비밀번호 입력폼
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value!.length < 6) {
                          return "비밀번호는 최소 6자 이상 입력해주세요";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "비밀번호를 입력해주세요",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
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
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "비밀번호 확인",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != userPW) {
                          return '비밀번호가 일치하지 않습니다';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "비밀번호를 다시 입력해주세요",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      obscureText: true,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "이름",
                      ),
                    ),
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
                      decoration: const InputDecoration(
                        hintText: "이름을 입력해주세요",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "전화번호",
                      ),
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value!.length != 13) {
                          return "올바른 전화번호를 입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userPhone = value;
                      },
                      decoration: const InputDecoration(
                        hintText: "010-0000-0000",
                        hintStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      inputFormatters: [MaskedInputFormatter("000-0000-0000")],
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "한밥 이용약관",
                            ),
                            value: _isChecked1,
                            onChanged: (value) {
                              setState(() {
                                _isChecked1 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountTerm()));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "개인정보 수집 및 이용 동의",
                            ),
                            value: _isChecked2,
                            onChanged: (value) {
                              setState(() {
                                _isChecked2 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.black,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyTerm()));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Visibility(
                        visible: _visibility,
                        child: const Text(
                          "약관에 동의해주세요",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                              if (validation) {
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifySignupPage()));
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
