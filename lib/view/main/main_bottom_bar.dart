import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/main_bottom_bar_controller.dart';

class MainBottomBar extends GetView<MainBottomBarController> {
  const MainBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => BottomNavigationBar(
        // 현재 인덱스를 selectedIndex에 저장
        currentIndex: controller.selectedIndex.value,
        // 선택된 label 안 보이게 설정
        showSelectedLabels: false,
        // 선택되지 않은 label도 안 보이게 설정
        showUnselectedLabels: false,
        // item tap할 시 실행
        onTap: controller.changeIndex,
        // tap animation
        type: BottomNavigationBarType.fixed,
        // bar에 보여질 요소. icon, label로 구성
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(controller.selectedIndex.value == 0
                ? CupertinoIcons.house_fill
                : CupertinoIcons.house),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(controller.selectedIndex.value == 1
                ? CupertinoIcons.person_2_fill
                : CupertinoIcons.person_2),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(controller.selectedIndex.value == 2
                ? CupertinoIcons.add_circled_solid
                : CupertinoIcons.add_circled),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(controller.selectedIndex.value == 3
                ? CupertinoIcons.chat_bubble_2_fill
                : CupertinoIcons.chat_bubble_2),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bars),
            label: "",
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}
