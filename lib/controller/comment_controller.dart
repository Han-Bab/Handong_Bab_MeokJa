import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/community_controller.dart';
import 'package:han_bab/model/comment_model.dart';

class CommentController extends GetxController {
  static CommentController instance = Get.find();

  var commentList = <CommentModel>[];
  var boardID;
  int index = 0;
  final authController = Get.put(AuthController());
  final communityController = Get.put(CommunityController());

  Future<void> getData() async {
    try {
      final comments = await FirebaseFirestore.instance
          .collection('community')
          .doc(boardID)
          .collection('comments')
          .orderBy('timestamp', descending: false)
          .get();
      commentList.clear();
      for (var comment in comments.docs) {
        commentList.add(CommentModel(
          comment['id'],
          comment['uid'],
          comment['writer'],
          comment['comment'],
          comment['regdate'],
          comment['regtime'],
          comment['timestamp'],
        ));
      }

      update();
    } catch (e) {
      Get.snackbar('에러', e.toString(),
          borderColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addComment(String id, int idx, String comment) async {
    DateTime dt = DateTime.now();
    try {
      final docID = FirebaseFirestore.instance.collection('community').doc().id;
      await FirebaseFirestore.instance
          .collection('community')
          .doc(id)
          .collection('comments')
          .doc(docID)
          .set({
        "id": docID,
        'uid': await authController.getUserInfo('uid'),
        'writer': await authController.getUserInfo('userNickName'),
        'comment': comment,
        'regdate': '${dt.month}/${dt.day}',
        'regtime': '${dt.hour}:${dt.minute}',
        'timestamp': Timestamp.now(),
      });

      final docRef = FirebaseFirestore.instance.collection('community').doc(id);
      int commentCount =
          await docRef.get().then((snapshot) => snapshot['commentCount']);
      docRef.update({
        'commentCount': commentCount + 1,
      });
      communityController.communityList[idx].commentCount += 1;
      Get.snackbar("알림", "댓글을 작성하셨습니다",
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 1));

      communityController.getData();
      communityController.update();
      getData();
      update();
    } catch (e) {
      Get.snackbar('에러', e.toString(), borderColor: Colors.red);
    }
  }

  Future<void> deleteComment(int index) async {
    String board = communityController.communityList[index].id;
    String commentID = commentList[index].id;
    try {
      final docRef =
          FirebaseFirestore.instance.collection('community').doc(board);
      int commentCount =
          await docRef.get().then((snapshot) => snapshot['commentCount']);
      commentCount -= 1;
      docRef.update({
        'commentCount': commentCount,
      });
      await FirebaseFirestore.instance
          .collection('community')
          .doc(board)
          .collection('comments')
          .doc(commentID)
          .delete();
      communityController.communityList[index].commentCount -= 1;
    } catch (e) {
      print(e);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      getData();
      update();
      communityController.getData();
      communityController.update();
      Get.snackbar("알림", "댓글을 삭제하셨습니다",
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 1));
    });
  }
}
