import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String id;
  String uid;
  String writer;
  String comment;
  String regdate;
  String regtime;
  Timestamp timestamp;

  CommentModel(this.id, this.uid, this.writer, this.comment, this.regdate,
      this.regtime, this.timestamp);
}
