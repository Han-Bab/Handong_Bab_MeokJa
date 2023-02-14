import 'package:get/get.dart';

class OrderTimeButtonController extends GetxController {
  static OrderTimeButtonController get to => Get.find();

  final RxString orderTime = '주문 예정 시간을 설정해주세요'.obs;

  void setOrderTime(String? selectedTime) {
    orderTime(selectedTime);
  }

}


class OrderTimeButtonController1 extends GetxController {
  static OrderTimeButtonController get to => Get.find();

  final RxString orderTime = '주문 예정 시간을 설정해주세요'.obs;

  void setOrderTime(String? selectedTime) {
    orderTime(selectedTime);
  }

}
