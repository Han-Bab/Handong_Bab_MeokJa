import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/mypage/edit_profile.dart';

class EditProfileName extends StatelessWidget {
  EditProfileName({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  final userName = TextEditingController(text: Get.arguments);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 이름 변경',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.off(() => EditProfile(), transition: Transition.upToDown);
            },
            onLongPress: null,
            child: const Text(
              '취소',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "프로필 이름",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextFormField(
                controller: userName,
                decoration: const InputDecoration(
                  hintText: "이름을 입력해주세요",
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF2F2F5),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: ElevatedButton(
          onPressed: () {
            authController.editInfo('userName', userName.text);
            Get.off(() => EditProfile(), transition: Transition.upToDown);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            elevation: 0,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: const Text(
            '저장하기',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
