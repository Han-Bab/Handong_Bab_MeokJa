import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');
String strToday = formatter.format(now);
DateFormat formatter1 = DateFormat.Hm();
String timeToday = formatter1.format(now);

class DatabaseService  extends GetxService{
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

  getUserName() async {
    var result = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return result['userName'];
  }

  // getting user data
  Future gettingUserData(String admin) async {
    QuerySnapshot snapshot =
        await userCollection.where("admin", isEqualTo: admin).get();
    return snapshot;
  }

  // get user group
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  String getImage(String imgName)  {
    if(imgName == "BBQ") {
      return "BBQ";
    } else if (imgName == "꼬꼬뽀끼") {
      return "kko";
    } else if (imgName == "동궁찜닭") {
      return "dong";
    } else if (imgName == "땅땅치킨") {
      return "ddang";
    } else if (imgName == "류엔돈까스") {
      return "ryu";
    } else if (imgName == "명성") {
      return "myeong";
    } else if (imgName == "삼촌네") {
      return "sam";
    } else if (imgName == "스시요시") {
      return "su";
    } else if (imgName == "신전떡볶이") {
      return "sin";
    } else if (imgName == "행복한 마라탕") {
      return "hang";
    } else {
      return "no file";
    }
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName,
      String orderTime, String pickup, String maxPeople) async {
    var urlRef = firebaseStorage.child('${getImage(groupName)}.jpg');
    var imgUrl;
    try {
      imgUrl = await urlRef.getDownloadURL();
    }catch(e) {
      var urlRef = firebaseStorage.child('hanbab_icon.png');
      imgUrl = await urlRef.getDownloadURL();
    }
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "orderTime": orderTime,
      "pickup": pickup,
      "currPeople": "1",
      "maxPeople": maxPeople,
      "imgUrl": imgUrl,
      "date": strToday,
      "recentMessage": "",
      "recentMessageSender": "",
      "recentMessageTime": "first",
      // "newPerson": "",
    });
    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    groupCollection.doc(groupDocumentReference.id).collection("messages").add({
      "newPerson": "${uid}_$userName",
      "inOut": "in",
      "time": DateFormat("yyyy-M-dd a h:mm:ss", "ko").format(DateTime.now()),
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  getGroupName(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['groupName'];
  }

  getGroupTime(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['orderTime'];
  }

  getGroupPick(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['pickup'];
  }

  getGroupMembers(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['members'];
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

  modifyGroupInfo(String groupId, String groupName, String orderTime,
      String pickup, String maxPeople) async {
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    var urlRef = firebaseStorage.child('${getImage(groupName)}.jpg');
    var imgUrl;
    try {
      imgUrl = await urlRef.getDownloadURL();
    }catch(e) {
      var urlRef = firebaseStorage.child('hanbab_icon.png');
      imgUrl = await urlRef.getDownloadURL();
    }
    await groupDocumentReference.update({
      "groupName": groupName,
      "orderTime": orderTime,
      "pickup": pickup,
      "maxPeople": maxPeople,
      "imgUrl": imgUrl
    });
    groupCollection.doc(groupId).collection("messages").add({
      "newPerson": "modify",
      "inOut": "modify",
      "time": DateFormat("yyyy-M-dd a h:mm:ss", "ko").format(DateTime.now()),
    });
    groupCollection.doc(groupId).update({
      "recentMessage": "",
      "recentMessageSender": "",
      "recentMessageTime": "",
    });

  }

  Future groupJoin(String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.where((name) => name.startWith(groupId)).isEmpty) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      });
      DocumentSnapshot groupDocumentSnapshot =
          await groupDocumentReference.get();
      List<dynamic> members = await groupDocumentSnapshot['members'];
      await groupDocumentReference.update({"currPeople": "${members.length}"});
      groupCollection.doc(groupId).collection("messages").add({
        "newPerson": "${uid}_$userName",
        "inOut": "in",
        "time": DateFormat("yyyy-M-dd a h:mm:ss", "ko").format(DateTime.now()),
      });
      groupCollection.doc(groupId).update({
        "recentMessage": "",
        "recentMessageSender": "",
        "recentMessageTime": "",
      });
    }
  }

  Future groupOut(String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.where((name) => name.startWith(groupId)).isEmpty) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"]),
      });
      groupCollection.doc(groupId).collection("messages").add({
        "newPerson": "${uid}_$userName",
        "inOut": "out",
        "time": DateFormat("yyyy-M-dd a h:mm:ss", "ko").format(DateTime.now()),
      });
      groupCollection.doc(groupId).update({
        "recentMessage": "",
        "recentMessageSender": "",
        "recentMessageTime": "",
      });
      DocumentSnapshot groupDocumentSnapshot =
          await groupDocumentReference.get();
      List<dynamic> members = await groupDocumentSnapshot['members'];
      await groupDocumentReference.update({"currPeople": "${members.length}"});
      if (members.isEmpty) groupCollection.doc(groupId).delete();
    }
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

class  FirestoreDB {
  //Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Restaurant>> getAllRestaurants() {
    return _firebaseFirestore
        .collection('groups')
        .where('date', isEqualTo: strToday)
        .where('orderTime', isGreaterThanOrEqualTo: timeToday)
        .orderBy('orderTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  getMyRestaurants(String myName) {
    return _firebaseFirestore
        .collection('groups')
        .where('members', arrayContains: myName)
        .orderBy('orderTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }

  getSearchRestaurants(String groupName) {
    return _firebaseFirestore
        .collection('groups')
        .where('groupName', isEqualTo: groupName)
        .where('date', isEqualTo: strToday)
        .where('orderTime', isGreaterThanOrEqualTo: timeToday)
        .orderBy('orderTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }
}
