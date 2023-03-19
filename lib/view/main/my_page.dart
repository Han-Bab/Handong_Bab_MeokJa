import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:han_bab/view/mypage/edit_profile.dart';
import 'package:han_bab/view/mypage/report_bug.dart';
import '../../component/customToolbarRect.dart';
import '../mypage/onboarding_page.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  bool kakaoCheck = false;
  bool tossCheck = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: CustomToolbarRect(
            title: "내 정보",
          )),
      body: GestureDetector(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
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
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                              },
                              future:
                                  authController.getUserInfo('userNickName'),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // FutureBuilder(
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot<dynamic> snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const CircularProgressIndicator
                            //           .adaptive();
                            //     }
                            //     if (snapshot.hasError) {
                            //       print(snapshot.error.toString());
                            //       return const Text("Error");
                            //     } else {
                            //       // print(snapshot.data);
                            //       return Text(
                            //         snapshot.data.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       );
                            //     }
                            //   },
                            //   future: authController.getUserInfo('userName'),
                            // ),
                            const SizedBox(
                              height: 10,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                              },
                              future: authController.getUserInfo('userEmail'),
                            ),
                            const SizedBox(
                              height: 5,
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
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                              },
                              future: authController.getUserInfo('userPhone'),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: 28,
                        // ),
                        Row(
                          children: [
                            Container(
                              width: 1,
                              height: 110,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 28,
                                  child: Text(
                                    '연결 계좌',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
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
                                          return Container(
                                            height: 25,
                                            width: 85,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: snapshot.data
                                                  ? const Color(0xFFFFEB03)
                                                  : Colors.grey[300],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                'Kakao',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: snapshot.data
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
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
                                          // print(snapshot.data);
                                          return Container(
                                            height: 25,
                                            width: 85,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: snapshot.data
                                                  ? const Color(0xFF3268E8)
                                                  : Colors.grey[300],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: Text(
                                                'Toss',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: snapshot.data
                                                      ? Colors.white
                                                      : Colors.white,
                                                  fontSize: 16,
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
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(() => EditProfile(),
                              transition: Transition.rightToLeft);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.orange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "프로필 관리",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 26,
                  height: 26,
                  child: Image.asset(
                    'assets/images/account.png',
                  ),
                ),
                title: const Text(
                  '계좌 연결하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(
                //   Icons.attach_money_sharp,
                //   color: Colors.black87,
                // ),
                onTap: () {
                  Get.to(() => OnboardingPage(), transition: Transition.zoom);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/images/mail.png',
                  ),
                ),
                title: const Text(
                  '고객센터',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(
                //   CupertinoIcons.ellipses_bubble,
                //   color: Colors.black87,
                // ),
                onTap: () {
                  Get.to(() => ReportBug(), transition: Transition.rightToLeft);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Container(
                  width: 23,
                  height: 23,
                  child: Image.asset(
                    'assets/images/logout.png',
                  ),
                ),
                title: const Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(
                //   Icons.exit_to_app_rounded,
                //   color: Colors.black87,
                // ),
                onTap: () {
                  AuthController.instance.logout();
                  AuthController.instance.logoutGoogle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
