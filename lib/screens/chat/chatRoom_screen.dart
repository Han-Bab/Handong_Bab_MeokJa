import 'package:flutter/material.dart';
import 'package:han_bab/screens/chat/new_message.dart';
import '../main/main_screen.dart';
import 'model.dart';
<<<<<<< Updated upstream
=======
import 'message.dart';

>>>>>>> Stashed changes

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
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext ctx){
                      return AlertDialog(
                        title: Text("나가기"),
                        content: Text("방에서 나가겠습니까?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("예"),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("아니오"),
                          )
                        ],
                      );
                    }
                );
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.blue,
              )
          )
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
