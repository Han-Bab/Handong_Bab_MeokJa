import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/community_controller.dart';

class Content extends StatelessWidget {
  Content({Key? key}) : super(key: key);

  final _commentFocusNode = FocusNode();
  final int idx = Get.arguments;
  final communityController = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Get.put(CommunityController());
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '음식게시판',
              ),
              elevation: 2,
              actions: <Widget>[
                PopupMenuButton(
                    onSelected: (String value) {
                      // do something with the selected value here
                    },
                    itemBuilder: (BuildContext ctx) => [
                          const PopupMenuItem(
                            value: '0',
                            child: Text('게시글 수정'),
                          ),
                          const PopupMenuItem(
                              value: '1', child: Text('게시글 삭제')),
                        ])
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GetBuilder<CommunityController>(
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          // CommunityTitle
                          SizedBox(
                            width: width,
                            child: Text(
                              controller.communityList[idx].title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // CommunityContent
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.communityList[idx].content,
                                  style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        '${controller.communityList[idx].likeCount}'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      CupertinoIcons.chat_bubble_fill,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        '${controller.communityList[idx].commentCount}'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.clickHeart(
                                        controller.communityList[idx].id, idx);
                                    Get.snackbar(
                                      '알림',
                                      '좋아요를 눌렀습니다',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.white,
                                      backgroundColor: Colors.lightBlue,
                                      duration:
                                          const Duration(milliseconds: 1500),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white70,
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '좋아요',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 30,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              child: TextFormField(
                                focusNode: _commentFocusNode,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  hintText: "댓글을 입력하세요.",
                                  hintStyle:
                                      new TextStyle(color: Colors.black26),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )));
  }
}
