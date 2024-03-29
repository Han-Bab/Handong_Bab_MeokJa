import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:han_bab/component/stateful_wrapper.dart';
import 'package:han_bab/controller/comment_controller.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/controller/content_controller.dart';
import 'package:han_bab/view/community/comments.dart';
import 'package:han_bab/view/community/edit_post.dart';

import '../main/main_screen.dart';

class Content extends StatelessWidget {
  Content({Key? key}) : super(key: key);

  final _commentFocusNode = FocusNode();

  final int idx = Get.arguments;
  final communityController = Get.put(CommunityController());
  final commentController = Get.put(CommentController());
  final contentController = Get.put(ContentController());
  final commentField = TextEditingController();

  FToast fToast = FToast();

  void _showToast(String msg, IconData icon, Color backgroundColor) {
    Widget toast = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    contentController.onReady();
    commentController.index = idx;

    return StatefulWrapper(
      onInit: () {
        fToast.init(context);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '음식게시판',
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () => iosShowBottomNotification(context),
                  icon: const Icon(CupertinoIcons.ellipsis_vertical))
            ],
          ),
          body: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 200), () {
              communityController.getData();
            }),
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
                    communityController.getData();
                    await commentController.getData();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, height * 0.1),
                      child: SingleChildScrollView(
                        child: Column(
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
                                      fontSize: 16,
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
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // content 내용
                            SizedBox(
                              width: width,
                              child: GetBuilder<ContentController>(
                                builder: (contentController) {
                                  return FutureBuilder(
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('');
                                      }
                                      if (snapshot.hasError) {
                                        print(snapshot.error.toString());
                                        return const Text("Error");
                                      } else {
                                        // print(snapshot.data);
                                        return Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    },
                                    future: contentController.getData('title'),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            // CommunityContent
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<ContentController>(
                                  builder: (contentController) {
                                    return FutureBuilder(
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          print(snapshot.error.toString());
                                          return const Text("Error");
                                        } else {
                                          // print(snapshot.data);
                                          return Expanded(
                                            child: Text(
                                              snapshot.data.toString(),
                                              style: const TextStyle(
                                                height: 1.5,
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      future:
                                          contentController.getData('content'),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // 좋아요 댓글 수
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
                                      GetBuilder<CommunityController>(
                                        builder: (communityController) {
                                          return Text(
                                              '${communityController.communityList[idx].likeCount}');
                                        },
                                      ),
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
                                      GetBuilder<CommunityController>(
                                        builder: (communityController) {
                                          return Text(
                                              '${communityController.communityList[idx].commentCount}');
                                        },
                                      ),
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
                                      _showToast("좋아요를 눌렀습니다!", Icons.favorite,
                                          Colors.orange);
                                      // Get.snackbar(
                                      //   '알림',
                                      //   '좋아요를 눌렀습니다',
                                      //   snackPosition: SnackPosition.TOP,
                                      //   colorText: Colors.orange,
                                      //   backgroundColor: Colors.white,
                                      //   duration:
                                      //       const Duration(milliseconds: 1000),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side:
                                          const BorderSide(color: Colors.black),
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
                            Comments(),
                          ],
                        ),
                      ),
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
                // height: height * 0.1,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 44),
                child: GetBuilder<CommentController>(
                  builder: (commentController) {
                    return Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 5,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                      ),
                      child: TextFormField(
                        controller: commentField,
                        maxLines: null,
                        scrollPhysics: const ClampingScrollPhysics(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 25),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: "댓글을 입력하세요",
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 14, height: 2.7),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                commentController.addComment(
                                    communityController.communityList[idx].id,
                                    idx,
                                    commentField.text);
                                commentField.clear();
                              },
                              child: Image.asset(
                                "assets/up.png",
                                scale: 2,
                              )),
                          isDense: true,
                        ),
                      ),
                      // TextFormField(
                      //   controller: commentField,
                      //   maxLines: null,
                      //   scrollPhysics: const ClampingScrollPhysics(),
                      //   keyboardType: TextInputType.text,
                      //   focusNode: _commentFocusNode,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.symmetric(horizontal: 25),
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     // border: OutlineInputBorder(
                      //
                      //     //   borderRadius: BorderRadius.circular(25),
                      //     // ),
                      //     hintText: "댓글을 입력하세요",
                      //     hintStyle: const TextStyle(
                      //         color: Colors.grey, fontSize: 14, height: 2.7),
                      //     suffixIcon: CircleAvatar(
                      //       backgroundColor: Colors.orange,
                      //       child: IconButton(
                      //         icon: const Icon(
                      //           Icons.arrow_upward_rounded,
                      //           size: 25,
                      //           color: Colors.white,
                      //         ),
                      //         onPressed: () {
                      //           commentController.addComment(
                      //               communityController.communityList[idx].id,
                      //               idx,
                      //               commentField.text);
                      //           commentField.clear();
                      //         },
                      //       ),
                      //     ),
                      //     isDense: true,
                      //   ),
                      // ),
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

  Future iosShowBottomNotification(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: contentController.isContentWriter
            ? [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.off(() => EditPost(), arguments: idx);
                  },
                  child: const Text("글 수정"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    contentController.deleteContent();
                    Get.snackbar('알림', '게시글을 삭제했습니다',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1000),
                        backgroundColor: Colors.orange,
                        colorText: Colors.white);
                    Get.off(() => MainScreen(), arguments: 1);
                  },
                  child: const Text("글 삭제"),
                ),
              ]
            : [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.snackbar('알림', '신고가 접수되었습니다.\n감사합니다.',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1000),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  },
                  child: const Text("신고하기"),
                ),
              ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("취소"),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
