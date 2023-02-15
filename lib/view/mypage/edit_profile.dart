import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/main/main_screen.dart';
import 'package:han_bab/view/main/my_page.dart';
import 'package:han_bab/view/mypage/edit_profile_name.dart';
import 'package:han_bab/view/mypage/edit_profile_nick.dart';
import 'package:han_bab/view/mypage/edit_profile_phone.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  String userName = '';
  String userNickName = '';
  String userPhone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 관리',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Get.off(() => MainScreen(),
                arguments: 4, transition: Transition.leftToRight);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "프로필 정보",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // User Name
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "이름",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xffF2F2F5),
                          side: BorderSide.none,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 10),
                          alignment: Alignment.centerLeft),
                      child: FutureBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return const Text("Error");
                          } else {
                            userName = snapshot.data.toString();
                            return Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        },
                        future: authController.getUserInfo('userName'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => EditProfileName(),
                      transition: Transition.downToUp,
                      arguments: userName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    '변경',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // User NickName
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "닉네임",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xffF2F2F5),
                          side: BorderSide.none,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 10),
                          alignment: Alignment.centerLeft),
                      child: FutureBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return const Text("Error");
                          } else {
                            userNickName = snapshot.data.toString();
                            return Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        },
                        future: authController.getUserInfo('userNickName'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.off(
                      () => EditProfileNick(),
                      arguments: userNickName,
                      transition: Transition.downToUp,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    '변경',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // User Phone
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "휴대폰",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xffF2F2F5),
                          side: BorderSide.none,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 10),
                          alignment: Alignment.centerLeft),
                      child: FutureBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return const Text("Error");
                          } else {
                            userPhone = snapshot.data.toString();
                            return Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        },
                        future: authController.getUserInfo('userPhone'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.off(
                      () => EditProfilePhone(),
                      arguments: userPhone,
                      transition: Transition.downToUp,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    '변경',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
