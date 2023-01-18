import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'menu.dart';

// 메시지 보내기
class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = "";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _userEnterMessage,
      'time': Timestamp.now(),
      'userID': user!.uid,
      'userName': userData.data()!['userName']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Menu()));
                },
                child: Image.asset(
                  "assets/images/menu.png",
                  scale: 11,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Expanded(
              child: Column(
            children: [
              Stack(children: [
                TextFormField(
                  maxLines: null,
                  controller: _controller,
                  decoration: InputDecoration(
                      labelText: 'Send a message...',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.blue))),
                  onChanged: (value) {
                    setState(() {
                      //user == value => 모든 키 입력에서 setState 메소드 실행
                      _userEnterMessage = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.fromLTRB(0, 17, 10, 0), // 패딩 설정
                      constraints: BoxConstraints(),
                      onPressed: _userEnterMessage.trim().isEmpty
                          ? null
                          : _sendMessage,
                      icon: Icon(Icons.send),
                      color: Colors.blue,
                    ),
                  ],
                )
              ]),
              SizedBox(height: 20),
            ],
          )),
        ],
      ),
    );
  }
}
