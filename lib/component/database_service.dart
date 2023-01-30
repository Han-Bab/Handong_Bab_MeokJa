import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');
String strToday = formatter.format(now);
DateFormat formatter1 = DateFormat.Hm();
String timeToday = formatter1.format(now);

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user group
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }
  int count=1;
  // creating a group
  Future createGroup(String userName, String id, String groupName,
      String orderTime, String pickup, String maxPeople) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "orderTime": orderTime,
      "pickup": pickup,
      "currPeople": "$count",
      "maxPeople": maxPeople,
      "imgUrl": "assets/images/$groupName.jpg",
      "date": strToday,
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future groupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    count++;
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "currPeople": "$count"
    });

    // DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    // List<dynamic> groups = await documentSnapshot['groups'];
    //
    // // if user has our groups -> then remove then or also in other part re join
    // if (groups.contains("${groupId}_$groupName")) {
    //   await userDocumentReference.update({
    //     "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
    //   });
    //   await groupDocumentReference.update({
    //     "members": FieldValue.arrayRemove(["${uid}_$userName"])
    //   });
    // } else {
    //   await userDocumentReference.update({
    //     "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
    //   });
    //   await groupDocumentReference.update({
    //     "members": FieldValue.arrayUnion(["${uid}_$userName"])
    //   });
    //}
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}

class FirestoreDB {
  //Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Restaurant>> getAllRestaurants() {
    return _firebaseFirestore
        .collection('groups')
        .where('date', isEqualTo: strToday)
        .where('orderTime',isGreaterThanOrEqualTo: timeToday)
        .orderBy('orderTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }
}
