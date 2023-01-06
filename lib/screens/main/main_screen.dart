import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/screens/chat/add_chat_room.dart';
import 'package:han_bab/screens/main/home_page.dart';
import 'package:han_bab/screens/main/profile_page.dart';
import 'group_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  // 새로운 유저가 채팅방으로 이동을 할 때 이 유저의 이메일 주소를 출력해보기 위한
  // state가 매번 초기화 될 때 이 과정을 진행하면 좋을 거 같아서 initState
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
        print(loggedUser!.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

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
          ProfilePage(),
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
