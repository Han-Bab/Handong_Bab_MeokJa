import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  String id;
  String title;
  String content;
  String uid;
  String writer;
  String regdate;
  String regtime;
  String visibility;
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
      this.visibility,
      this.timestamp,
      this.likeCount,
      this.commentCount);
}
