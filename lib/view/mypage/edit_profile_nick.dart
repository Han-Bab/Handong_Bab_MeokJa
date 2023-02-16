import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/view/mypage/edit_profile.dart';

class EditProfileNick extends StatefulWidget {
  const EditProfileNick({Key? key}) : super(key: key);

  @override
  State<EditProfileNick> createState() => _EditProfileNickState();
}

class _EditProfileNickState extends State<EditProfileNick> {
  final authController = Get.put(AuthController());
  final userNickName = TextEditingController(text: Get.arguments);

  final _formKey = GlobalKey<FormState>();
  bool validation = false;
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      setState(() {
        validation = true;
      });
      _formKey.currentState!.save();
    }
    if (!isValid) {
      setState(() {
        validation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 닉네임 변경',
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
      body: Form(
        key: _formKey,
        child: GestureDetector(
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
                    "프로필 닉네임",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextFormField(
                  controller: userNickName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "닉네임을 입력해주세요.";
                    }
                    if (value.length > 7) {
                      return "7자 이하로 설정해주세요.";
                    }
                    if (!authController.isUniqueNick.value) {
                      return "중복된 닉네임입니다. 다시 설정해주세요.";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "닉네임을 입력해주세요",
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
      ),
      bottomSheet: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: ElevatedButton(
          onPressed: () async {
            try {
              print('닉네임 중복 체크');
              authController.isUniqueNick.value =
                  await authController.checkNickName(userNickName.text);
            } catch (e) {
              print(e.toString());
            }
            _tryValidation();
            if (validation) {
              authController.editInfo(
                  'userNickName', Get.arguments, userNickName.text);
              Get.off(() => EditProfile(), transition: Transition.upToDown);
            }
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
