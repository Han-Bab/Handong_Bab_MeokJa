import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/comment_controller.dart';

class Comments extends GetView<CommentController> {
  Comments({Key? key}) : super(key: key);
  final commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
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
            );
          },
        );
      },
    );
  }
}
