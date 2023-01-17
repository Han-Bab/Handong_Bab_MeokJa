import 'package:get/get.dart';
import 'package:han_bab/view/chat/add_chat_room.dart';

class MainBottomBarController extends GetxController {
  // Get.find 대신 클래스명으로 사용 가능
  static MainBottomBarController get to => Get.find();

  // 현재 선택된 탭 아이템 idx 저장
  final RxInt selectedIndex = 0.obs;

  // tap 이벤트 발생 시 selectedIndex value 변경 함수
  void changeIndex(int index) {
    selectedIndex(index);
    if (selectedIndex.value == 2) {
      Get.off(AddChatRoom());
    }
  }
}
