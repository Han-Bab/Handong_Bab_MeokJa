import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';

import '../component/database_service.dart';

class MyController extends GetxController {
  RxList<Restaurant> myRestaurant = <Restaurant>[].obs;

  @override
  Future<void> onInit() async {
    var result = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    myRestaurant.bindStream(FirestoreDB().getMyRestaurants("${result['uid']}_${result['userNickName']}"));
    //FirestoreDB().getMyRestaurants(result['groups']);
    super.onInit();
  }
}
