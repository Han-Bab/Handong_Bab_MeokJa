import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = "";
  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(),
      'userID' : user!.uid,
      'userName' : userData.data()!['userName']
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
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    TextField(
                      maxLines: null,
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Send a message...'
                      ),
                      onChanged: (value){
                        setState(() { //user == value => 모든 키 입력에서 setState 메소드 실행
                          _userEnterMessage = value;
                        });
                      },
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              )
          ),
          Column(
            children: [
              IconButton(
                  onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.blue,
              ),
              const SizedBox(height: 50),
            ],
          )
        ],
      ),
    );
  }
}
