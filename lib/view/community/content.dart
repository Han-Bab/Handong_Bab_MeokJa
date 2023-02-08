import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/comment_controller.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/view/community/comments.dart';

class Content extends StatelessWidget {
  Content({Key? key}) : super(key: key);

  final _commentFocusNode = FocusNode();

  final int idx = Get.arguments;

  final communityController = Get.put(CommunityController());

  final commentController = Get.put(CommentController());

  final commentField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
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
                        const PopupMenuItem(value: '1', child: Text('게시글 삭제')),
                      ])
            ],
          ),
          body: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 200),
                () => commentController.getData(commentController.boardID)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                return RefreshIndicator(
                  onRefresh: () async {
                    await commentController.getData(commentController.boardID);
                    commentController.update();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, height * 0.08),
                    child: GetBuilder<CommunityController>(
                      builder: (communityController) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // userinfo
                                      SizedBox(
                                        child: Text(
                                          communityController
                                              .communityList[idx].writer,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          '${communityController.communityList[idx].regdate} | ${communityController.communityList[idx].regtime}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // CommunityTitle
                                  SizedBox(
                                    width: width,
                                    child: Text(
                                      communityController
                                          .communityList[idx].title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // CommunityContent
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          communityController
                                              .communityList[idx].content,
                                          style: const TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // 좋아요 댓글 수
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                '${communityController.communityList[idx].likeCount}'),
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
                                                '${communityController.communityList[idx].commentCount}'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            communityController.clickHeart(
                                                communityController
                                                    .communityList[idx].id,
                                                idx);
                                            Get.snackbar(
                                              '알림',
                                              '좋아요를 눌렀습니다',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.lightBlue,
                                              duration: const Duration(
                                                  milliseconds: 1500),
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
                                                style: TextStyle(
                                                    color: Colors.red),
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
                              Comments(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          bottomSheet: // 댓글 입력창 파트
              GestureDetector(
            child: SafeArea(
              child: Container(
                height: height * 0.08,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: GetBuilder<CommentController>(
                  builder: (commentController) {
                    return TextFormField(
                      controller: commentField,
                      focusNode: _commentFocusNode,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: "댓글을 입력하세요.",
                        hintStyle: TextStyle(color: Colors.black26),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            commentController.addComment(
                                communityController.communityList[idx].id,
                                idx,
                                commentField.text);
                            commentField.clear();
                          },
                        ),
                        isDense: true,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
