import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String groupName;
  final String groupId;
  final String imgUrl;
  final String date;
  final String orderTime;
  final String currPeople;
  final String maxPeople;
  final String admin;
  final String pickup;

  Restaurant({
    required this.groupName,
    required this.groupId,
    required this.imgUrl,
    required this.date,
    required this.orderTime,
    required this.currPeople,
    required this.maxPeople,
    required this.admin,
    required this.pickup
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
        pickup: snap['pickup']
    );
    return restaurant;
  }
}