import 'package:flutter/material.dart';

import '../main/main_screen.dart';
import '../main/model.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero, // 패딩 설정
          constraints: const BoxConstraints(), // constraints
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainScreen()));
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          chat.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            //Image.asset(chat.imgae),
          ],
        ),
      ),
    );
  }
}
