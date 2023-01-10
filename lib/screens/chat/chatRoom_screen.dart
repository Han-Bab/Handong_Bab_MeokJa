import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:han_bab/screens/chat/new_message.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main/main_screen.dart';
import 'chat_bubble.dart';
import 'model.dart';
import 'message.dart';


class ChatRoom extends StatelessWidget {
  ChatRoom({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  //final Uri _url = Uri.parse('https://qr.kakaopay.com/FTH8NL7za');
  final Uri _url = Uri.parse('https://toss.me/quokkalove/20');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
    // try {
    //   User user = await UserApi.instance.me();
    //   print('사용자 정보 요청 성공'
    //       '\n회원번호: ${user.id}');
    // } catch (error) {
    //   print('사용자 정보 요청 실패 $error');
    // }
  }

  void nextPage(context) {
    // 상세 페이지 넘겨주기
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
          );
        });
  }

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
        iconTheme: IconThemeData(color: Colors.black),

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
      endDrawer: Drawer(
          child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('대화상대'),
                ),
                Column(
                  children: [
                    ListTile(
                        leading: Text("👑", style: TextStyle(fontSize: 25),),
                        title: Text("관리자"),
                        onTap: (){
                          nextPage(context);
                        }
                    ),
                    ListTile(
                        leading: Text(" "),
                        title: Text("1"),
                        onTap: (){
                          nextPage(context);
                        }
                    ),
                    ListTile(
                        leading: Text(" "),
                        title: Text("2"),
                        onTap: (){nextPage(context);}
                    ),

                  ],
                ),
                Container(
                    child: Divider(color: Colors.grey, thickness: 1.0, indent: 20, endIndent: 20, height: 1,)),
                ListTile(
                  leading: Icon(Icons.logout,),
                  title: Text('방 나가기'),
                  onTap: (){
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
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const MainScreen()));
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
                ),

              ]
          )
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
