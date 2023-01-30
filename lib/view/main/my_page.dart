import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';

import '../mypage/setting_page.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  var kakaoCheck = false;
  var tossCheck = false;

  @override
  Widget build(BuildContext context) {

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
                            const Text(
                               '감자튀김',
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
                                    GestureDetector(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: kakaoCheck
                                                ? const Color(0xFFFFEB03)
                                                : Colors.grey,
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
                                      ),
                                      onTap: () {
                                        
                                      },
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Container(
                                          height: 25,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: tossCheck
                                                ? const Color(0xFF3268E8)
                                                : Colors.grey,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              'Toss',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: tossCheck
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 17,
                                                fontWeight: tossCheck
                                                    ? FontWeight.w500
                                                    : FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        
                                      },
                                    )
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
                              '이름',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Text('윤유원',style: TextStyle(
                              fontSize: 18,
                            ),),
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
                              width: 40,
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
                                              hintText: '010 - 1234 - 5678'),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PlusPage()),
                      // );
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
                        MaterialPageRoute(builder: (context) => const SettingPage()),
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
