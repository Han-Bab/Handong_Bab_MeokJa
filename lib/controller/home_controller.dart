import 'package:get/get.dart';
import 'package:han_bab/component/database_service.dart';
import 'package:han_bab/model/restaurant.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final restaurants = <Restaurant>[].obs;

  @override
  void onInit() {
    restaurants.bindStream(FirestoreDB().getAllRestaurants());
    super.onInit();
  }
}