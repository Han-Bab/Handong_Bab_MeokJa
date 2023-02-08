import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  String id;
  String title;
  String content;
  String uid;
  String writer;
  String regdate;
  String regtime;
  Timestamp timestamp;
  int likeCount;
  int commentCount;

  CommunityModel(
      this.id,
      this.title,
      this.content,
      this.uid,
      this.writer,
      this.regdate,
      this.regtime,
      this.timestamp,
      this.likeCount,
      this.commentCount);
}
