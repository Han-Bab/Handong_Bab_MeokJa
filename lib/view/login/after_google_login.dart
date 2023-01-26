import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/main/main_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get.dart';

class AfterGoogleLogin extends StatefulWidget {
  const AfterGoogleLogin({Key? key}) : super(key: key);

  @override
  State<AfterGoogleLogin> createState() => _AfterGoogleLoginState();
}

class _AfterGoogleLoginState extends State<AfterGoogleLogin> {
  bool _showSpinner = false;
  bool _validation = false;

  final _googleFormKey = GlobalKey<FormState>();

  void _tryValidation() {
    final isValid = _googleFormKey.currentState!.validate();
    if (isValid) {
      _googleFormKey.currentState!.save();
      setState(() {
        _validation = true;
      });
    }
    if (!isValid) {
      setState(() {
        _validation = false;
      });
    }
  }

  final authController = Get.put(AuthController());

  Map userInfo = {
    'userEmail': '',
    'userName': '',
    'userPhone': '',
    'userNickName': '',
    'userAccount': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('추가 정보 입력'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Form(
          key: _googleFormKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "한동 계정",
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey),
                            padding:
                                EdgeInsets.only(top: 16, bottom: 16, left: 10),
                            alignment: Alignment.centerLeft),
                        child: Text(
                          authController.authentication.currentUser!.email
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
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
                      key: ValueKey(1),
                      onChanged: (value) {
                        userInfo['userName'] = value;
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
                      key: ValueKey(2),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value!.length != 13) {
                          return "올바른 전화번호를 입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userInfo['userPhone'] = value;
                      },
                      decoration: const InputDecoration(
                        hintText: "010-0000-0000",
                        hintStyle: TextStyle(fontSize: 12),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "닉네임",
                      ),
                    ),
                    TextFormField(
                      key: ValueKey(3),
                      onChanged: (value) {
                        userInfo['userNickName'] = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "닉네임을 입력해주세요";
                        }
                        if (value.length > 7) {
                          return "7자 이하로 설정해주세요";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "ex) 호빵이",
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
                        "주계좌번호",
                      ),
                    ),
                    TextFormField(
                      key: ValueKey(4),
                      onChanged: (value) {
                        userInfo['userAccount'] = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "사용할 계좌번호를 입력해주세요";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "ex) 우리 1002452023325",
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: ElevatedButton(
                            onPressed: () {
                              authController.logout();
                              authController.logoutGoogle();
                            },
                            child: Text("나중에 하기"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: ElevatedButton(
                            onPressed: () {
                              userInfo['userEmail'] = authController
                                  .authentication.currentUser!.email
                                  .toString();
                              setState(() {
                                _showSpinner = true;
                              });
                              _tryValidation();
                              if (_validation) {
                                authController.addInfo(userInfo);
                                Get.snackbar('알림', '정보가 저장되었습니다.',
                                    snackPosition: SnackPosition.TOP);
                                Get.off(() => MainScreen());
                              }
                              setState(() {
                                _showSpinner = false;
                              });
                            },
                            child: Text("저장하기"),
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
