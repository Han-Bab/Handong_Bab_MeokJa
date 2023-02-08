import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../mypage/onboarding_page.dart';
import '../mypage/setting_page.dart';
import 'main_screen.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  bool kakaoCheck = false;
  bool tossCheck = false;

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    void getLinkStatus(String link) async {
      kakaoCheck = await authController.checkUserLink(link);
      // print(kakaoCheck);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            icon: const Icon(Icons.refresh)
        ),
        title: const Text("마이페이지"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return const Text("Error");
                                    } else {
                                      // print(snapshot.data);
                                      return Text(
                                        snapshot.data.toString(),
                                        style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 8,
                                        ),
                                      );
                                    }
                                  },
                                  future: authController.getUserInfo('userName'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: FutureBuilder(
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator
                                            .adaptive();
                                      }
                                      if (snapshot.hasError) {
                                        print(snapshot.error.toString());
                                        return const Text("Error");
                                      } else {
                                        // print(snapshot.data);
                                        return Text(
                                          snapshot.data.toString(),
                                        );
                                      }
                                    },
                                    future: authController.getUserInfo('userEmail'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 1,
                                  height: 75,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: FutureBuilder(
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator
                                                  .adaptive();
                                            }
                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return Text("Error");
                                            } else {
                                              print(snapshot.data);
                                              return Container(
                                                height: 25,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: snapshot.data
                                                      ? const Color(0xFFFFEB03)
                                                      : Colors.grey,
                                                ),
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    'Kakao',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          future: authController
                                              .checkUserLink('kakaoLink'),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: FutureBuilder(
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator
                                                  .adaptive();
                                            }
                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return const Text("Error");
                                            } else {
                                              print(snapshot.data);
                                              return Container(
                                                height: 25,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: snapshot.data
                                                      ? const Color(0xFF3268E8)
                                                      : Colors.grey,
                                                ),
                                                child: Padding(
                                                  padding:
                                                    EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    'Toss',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: snapshot.data
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 17,
                                                      fontWeight: snapshot.data
                                                          ? FontWeight.w500
                                                          : FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          future: authController
                                              .checkUserLink('tossLink'),
                                        ),
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 90,
                                  child: Text(
                                    '닉네임',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return const Text("Error");
                                    } else {
                                      // print(snapshot.data);
                                      return Text(
                                        snapshot.data.toString(),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          letterSpacing: 3,
                                        ),
                                      );
                                    }
                                  },
                                  future:
                                      authController.getUserInfo('userNickName'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              height: 25,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      var nickNameController =
                                      TextEditingController();
                                      return AlertDialog(
                                        title: const Text('닉네임 수정'),
                                        content: TextFormField(
                                          controller: nickNameController,
                                          decoration: const InputDecoration(
                                              hintText: '새로운 닉네임을 작성해 주세요.'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              var nickName =
                                                  nickNameController.text;
                                              Navigator.pop(context);
                                            },
                                            child: const Text('저장'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(top: 0),
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 0.7,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    '수정',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 95,
                                  child: Text(
                                    '전화번호',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return Text("Error");
                                    } else {
                                      // print(snapshot.data);
                                      return Text(
                                        snapshot.data.toString(),
                                      );
                                    }
                                  },
                                  future:
                                      authController.getUserInfo('userPhone'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              height: 25,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      var phoneNumberController =
                                          TextEditingController();
                                      return AlertDialog(
                                        title: const Text('전화번호 수정'),
                                        content: TextFormField(
                                          controller: phoneNumberController,
                                          decoration: const InputDecoration(
                                              hintText: '010 - 0000 - 0000'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              var phoneNumber =
                                                  phoneNumberController.text;
                                              Navigator.pop(context);
                                            },
                                            child: const Text('저장'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(top: 0),
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 0.7,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    '수정',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 95,
                                  child: Text(
                                    '계좌번호',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return const Text("Error");
                                    } else {
                                      // print(snapshot.data);
                                      return Text(
                                        snapshot.data.toString(),
                                      );
                                    }
                                  },
                                  future:
                                      authController.getUserInfo('userAccount'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              height: 25,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      var accountController =
                                          TextEditingController();
                                      return AlertDialog(
                                        title: const Text('계좌번호 수정'),
                                        content: TextFormField(
                                          controller: accountController,
                                          decoration: const InputDecoration(
                                              hintText: '우리 1002233487645'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              var account =
                                                  accountController.text;
                                              Navigator.pop(context);
                                            },
                                            child: const Text('저장'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(top: 0),
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 0.7,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    '수정',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      '카카오 및 토스 연결 방법',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.attach_money_sharp,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OnboardingPage()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      '환경설정',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.settings,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      '로그아웃',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      AuthController.instance.logout();
                      AuthController.instance.logoutGoogle();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
