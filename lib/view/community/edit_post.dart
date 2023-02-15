import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/controller/content_controller.dart';
import 'package:han_bab/view/community/content.dart';

class EditPost extends StatelessWidget {
  EditPost({Key? key}) : super(key: key);

  final int index = Get.arguments;
  final communityController = Get.put(CommunityController());
  final contentController = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController(
        text: communityController.communityList[index].title);
    final content = TextEditingController(
        text: communityController.communityList[index].content);

    // String title = communityController.communityList[index].title;
    // String content = communityController.communityList[index].content;

    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.xmark),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.location),
            onPressed: () {
              print('Edit Post');
              contentController.editData(title.text, content.text, index);
              Get.back();
              Get.snackbar(
                '알림',
                '게시글을 수정하였습니다',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(milliseconds: 1500),
                backgroundColor: Colors.lightBlue,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: '제목',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            height: 150,
            child: TextFormField(
              controller: content,
              textInputAction: TextInputAction.go,
              maxLines: null,
              decoration: const InputDecoration(
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
