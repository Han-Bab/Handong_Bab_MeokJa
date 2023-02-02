import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/model/community_model.dart';

class CommunityController extends GetxController {
  static CommunityController instance = Get.find();

  var communityList = <CommunityModel>[];
  final authController = Get.put(AuthController());

  Future<void> getData() async {
    try {
      final community = await FirebaseFirestore.instance
          .collection('community')
          .orderBy('timestamp', descending: true)
          .get();
      communityList.clear();
      for (var board in community.docs) {
        communityList.add(CommunityModel(
          board['id'],
          board['title'],
          board['content'],
          board['uid'],
          board['writer'],
          board['regdate'],
          board['regtime'],
          board['timestamp'],
          board['likeCount'],
          board['commentCount'],
        ));
      }
    } catch (e) {
      Get.snackbar('에러', e.toString(), borderColor: Colors.red);
    }
  }

  Future<void> addData(String title, String content) async {
    DateTime dt = DateTime.now();
    try {
      final docID = FirebaseFirestore.instance.collection('community').doc().id;
      await FirebaseFirestore.instance.collection('community').doc(docID).set({
        'id': docID,
        'uid': await authController.getUserInfo('uid'),
        'writer': await authController.getUserInfo('userNickName'),
        'title': title,
        'content': content,
        'regdate': '${dt.month}/${dt.day}',
        'regtime': '${dt.hour}:${dt.minute}',
        'timestamp': Timestamp.now(),
        'likeCount': 0,
        'commentCount': 0,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> clickHeart(String id, int idx) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('community').doc(id);
      int likeCount =
          await docRef.get().then((snapshot) => snapshot['likeCount']);
      docRef.update({
        'likeCount': likeCount + 1,
      });
      communityList[idx].likeCount += 1;
    } catch (e) {
      print(e);
    }
    update();
  }

  void addComment(String id, int idx, String comment) {
    try {} catch (e) {
      print(e);
    }
  }
}
