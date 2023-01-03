import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/screens/chat/add_chat_room.dart';
import 'package:han_bab/screens/main/home_page.dart';

import 'group.screen.dart';
import 'mychat_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          HomePage(),
          Container(
            color: Colors.accents[4],
          ),
          Container(
            color: Colors.accents[7],
          ),
          GroupListViewDemo(),
          Container(
            color: Colors.accents[12],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _bottomSelectedIndex,
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
            if (_bottomSelectedIndex == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddChatRoom()));
              _bottomSelectedIndex = 0;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_bottomSelectedIndex == 0
                ? CupertinoIcons.house_fill
                : CupertinoIcons.house),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(_bottomSelectedIndex == 1
                ? CupertinoIcons.person_2_fill
                : CupertinoIcons.person_2),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(_bottomSelectedIndex == 2
                ? CupertinoIcons.add_circled_solid
                : CupertinoIcons.add_circled),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(_bottomSelectedIndex == 3
                ? CupertinoIcons.chat_bubble_2_fill
                : CupertinoIcons.chat_bubble_2),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bars),
            label: "",
          ),
        ],
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(
          size: 28,
        ),
      ),
    );
  }
}
