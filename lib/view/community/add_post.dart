import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/view/main/main_screen.dart';

import '../../controller/auth_controller.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);

  final communityController = Get.put(CommunityController());
  final authController = Get.put(AuthController());

  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: () {
            Get.off(() => MainScreen(), arguments: 1);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.location),
            onPressed: () {
              print('Add Post');
              communityController.addData(title, content);
              Get.off(() => MainScreen(), arguments: 1);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: TextFormField(
              onChanged: (value) {
                title = value;
              },
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                hintText: '제목',
              ),
            ),
          ),
          const Divider(
            // color: Color(0xffF2F2F5),
            height: 10,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            height: 150,
            child: TextFormField(
              onChanged: (value) {
                content = value;
              },
              textInputAction: TextInputAction.go,
              maxLines: null,
              decoration: const InputDecoration(
                filled: false,
                hintText: '내용을 입력하세요.',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
