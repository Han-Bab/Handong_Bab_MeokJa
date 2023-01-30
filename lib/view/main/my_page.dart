import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var kakaoCheck = true;
  var tossCheck = true;

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    print(authController.getUserInfo('userName'));

    return Scaffold(
      appBar: AppBar(
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
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
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
                                    if (kakaoCheck == false)
                                      (Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              'Kakao',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                    else if (kakaoCheck == true)
                                      (Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color(0xFFFFEB03),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              'Kakao',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    if (tossCheck == false)
                                      (Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              'Toss',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                    else
                                      (Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color(0xFF3268E8),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              'Toss',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              '이메일',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text('yuwon0628@handong.ac.kr'),
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
                              children: const [
                                Text(
                                  '전화번호',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('010 - 9315 - 6383'),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              height: 25,
                              child: TextButton(
                                onPressed: () {},
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
                              children: const [
                                Text(
                                  '계좌번호',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('토스뱅크 100013557921'),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              height: 25,
                              child: TextButton(
                                onPressed: () {},
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
                Column(
                  children: [
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
                        onTap: () {},
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
              ],
            ),
          );
        },
      ),
    );
  }
}
