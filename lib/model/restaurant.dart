import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String groupName;
  final String groupId;
  final String imgUrl;
  final String date;
  String orderTime;
  final String currPeople;
  String maxPeople;
  final String admin;
  String pickup;
  List<dynamic> members;

  Restaurant({
    required this.groupName,
    required this.groupId,
    required this.imgUrl,
    required this.date,
    required this.orderTime,
    required this.currPeople,
    required this.maxPeople,
    required this.admin,
    required this.pickup,
    required this.members
  });


  static Restaurant fromSnapshot(DocumentSnapshot snap) {
    Restaurant restaurant = Restaurant(
        groupName: snap['groupName'],
        groupId: snap['groupId'],
        imgUrl: snap['imgUrl'],
        date: snap['date'],
        orderTime: snap['orderTime'],
        currPeople: snap['currPeople'],
        maxPeople: snap['maxPeople'],
        admin: snap['admin'],
        pickup: snap['pickup'],
        members: snap['members']
    );
    return restaurant;
  }
}
