import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/controller/content_controller.dart';
import '../../controller/comment_controller.dart';

class Comments extends GetView<CommentController> {
  Comments({Key? key}) : super(key: key);
  final communityController = Get.put(CommunityController());
  final commentController = Get.put(CommentController());
  final authController = Get.put(AuthController());
  final contentController = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    commentController.getData();
    return GetBuilder<CommentController>(
      builder: (commentController) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: commentController.commentList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentController.commentList[index].writer,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    commentController.commentList[index].comment,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                '${commentController.commentList[index].regdate} | ${commentController.commentList[index].regtime}',
                style: const TextStyle(fontSize: 13),
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => iosShowBottomNotification(context, index),
                icon: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                  size: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future iosShowBottomNotification(BuildContext context, int index) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: authController.authentication.currentUser?.uid ==
                commentController.commentList[index].uid
            ? [
                CupertinoActionSheetAction(
                  onPressed: () {
                    commentController.deleteComment(index);
                    commentController.update();
                    Get.back();
                  },
                  child: Text("삭제하기"),
                ),
              ]
            : [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Get.snackbar('알림', '신고가 접수되었습니다.\n감사합니다.',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(milliseconds: 1200),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  },
                  child: Text("신고하기"),
                ),
              ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("취소"),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
