import 'package:flutter/material.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/main_bottom_bar_controller.dart';
import 'package:han_bab/view/main/main_bottom_bar.dart';
import 'package:han_bab/view/main/home_page.dart';
import 'package:han_bab/view/main/my_page.dart';
import '../../component/stateful_wrapper.dart';
import 'community_page.dart';
import 'group_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  int index = Get.arguments ?? 0;
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final mainBottomBarController = Get.put(MainBottomBarController());

    return StatefulWrapper(
      // 새로운 유저가 채팅방으로 이동을 할 때 이 유저의 이메일 주소를 출력해보기 위한
      // state가 매번 초기화 될 때 이 과정을 진행하면 좋을 거 같아서 initState
      onInit: () {
        mainBottomBarController.selectedIndex(index);
        authController.getCurrentUser();
      },
      child: Scaffold(
        body: Obx(
          () => SafeArea(
            child: IndexedStack(
              index: mainBottomBarController.selectedIndex.value,
              children: [
                HomePage(),
                CommunityPage(),
                Container(),
                GroupListViewDemo(),
                MyPage(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MainBottomBar(),
      ),
    );
  }
}
