import 'package:flutter/cupertino.dart';
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

  bool _isClicked = false;
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
        title: const Text('추가 정보 입력'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            authController.logout();
            authController.logoutGoogle();
          },
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
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
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "한동 이메일",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xffF2F2F5),
                            side: BorderSide.none,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        filled: true,
                        fillColor: Color(0xffF2F2F5),
                        hintText: "이름을 입력해주세요",
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none,
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
                        "휴대폰",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        filled: true,
                        fillColor: Color(0xffF2F2F5),
                        hintText: "010-0000-0000",
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        if (!_isClicked) {
                          return '중복 확인을 해주세요';
                        } else if (!authController.isUniqueNick.value) {
                          return '중복된 닉네임이 존재합니다';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF2F2F5),
                        hintText: "예 : 한동이",
                        hintStyle: const TextStyle(fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.white))),
                          child: TextButton(
                            onPressed: () async {
                              _isClicked = true;
                              try {
                                print('닉네임 중복 체크');
                                authController.isUniqueNick.value =
                                    await authController.checkNickName(
                                        userInfo['userNickName']);
                              } catch (e) {
                                print(e.toString());
                              }
                              print(authController.isUniqueNick.value);
                              _tryValidation();
                              if (userInfo['userNickName'] != '') {
                                if (authController.isUniqueNick.value) {
                                  Get.snackbar('알림', '사용하실 수 있는 닉네임입니다!',
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  Get.snackbar('알림', '중복된 닉네임입니다!\n다시 작성해주세요',
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              }
                            },
                            child: Text('중복'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              // backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(30),
        child: Row(
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
      ),
    );
  }
}
