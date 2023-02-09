import 'package:flutter/material.dart';
import 'package:han_bab/component/stateful_wrapper.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/main_bottom_bar_controller.dart';
import 'package:han_bab/view/main/main_bottom_bar.dart';
import 'package:han_bab/view/main/home_page.dart';
import 'package:han_bab/view/main/my_page.dart';
import 'community_page.dart';
import 'group_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  int index = Get.arguments ?? 0;

  final authController = Get.put(AuthController());
  final mainBottomBarController = Get.put(MainBottomBarController());
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => mainBottomBarController.changeIndex(index),
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
