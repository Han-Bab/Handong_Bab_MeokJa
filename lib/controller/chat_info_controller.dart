import 'package:get/get.dart';

class ChatInfoController extends GetxController {
  var restaurantName = "".obs;
  var orderTime = "".obs;
  var pickUp = "".obs;
  var currPeople = "".obs;
  var maxPeople = "".obs;
  var member = [].obs;


  @override
  void onInit() {
    super.onInit();
  }

  setInfo(restaurantName, orderTime, pickUp, currPeople, maxPeople, member) {
    this.restaurantName.value = restaurantName;
    this.orderTime.value = orderTime;
    this.pickUp.value = pickUp;
    this.currPeople.value = currPeople;
    this.maxPeople.value = maxPeople;
    this.member.value = member;
  }
}