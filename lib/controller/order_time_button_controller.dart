import 'dart:math';

import 'package:get/get.dart';

class OrderTimeButtonController extends GetxController {
  static OrderTimeButtonController get to => Get.find();

  final RxString orderTime = '주문 예정 시간을 설정해주세요'.obs;

  void setOrderTime(String? _selectedTime) {
    orderTime(_selectedTime);
  }
}
