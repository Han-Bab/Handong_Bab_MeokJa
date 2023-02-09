import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/community_controller.dart';

class ContentController extends GetxController {
  static ContentController instance = Get.find();

  final authController = Get.put(AuthController());
  final communityController = Get.put(CommunityController());
  String contentUID = '';
  String contentID = '';
  bool isContentWriter = false;
  String title = '';
  String content = '';

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkUID();
  }

  void checkUID() {
    if (contentUID == authController.authentication.currentUser?.uid) {
      isContentWriter = true;
    } else {
      isContentWriter = false;
    }
  }

  Future<String> getData(String str) async {
    final content = await FirebaseFirestore.instance
        .collection('community')
        .doc(contentID)
        .get();
    return content[str];
  }

  Future<void> editData(String title, String content, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('community')
          .doc(contentID)
          .update({
        'title': title,
        'content': content,
      });
      communityController.communityList[index].title = title;
      communityController.communityList[index].content = content;
      update();
    } catch (e) {
      print(e);
    }
  }

  void deleteContent() {
    FirebaseFirestore.instance.collection('community').doc(contentID).delete();
  }
}
