import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/view/chat/chatService.dart';
import '../main/main_screen.dart';
import 'model.dart';
import 'message.dart';
import 'new_message.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({Key? key, required this.chat}) : super(key: key);

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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatService()));
              },
              icon: Icon(
                CupertinoIcons.bars,
                color: Colors.blue,
              ))
        ],
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
      body: Container(
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
