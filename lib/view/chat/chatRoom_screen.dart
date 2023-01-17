import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main/main_screen.dart';
import 'model.dart';
import 'message.dart';
import 'new_message.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late Uri _url;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
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

  void payModal(context) {
    bool visibility = false;
    String account = "농협 333-3333-3333-33";
    // var f = NumberFormat('###,###,###,###');
    // int price = 1000000;
    // String toHexValue(int value){
    //   return (value * 524288).toRadixString(16);
    // }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 10),
                  child: Column(children: [
                    const Text(
                      "관리자",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      account,
                      style: TextStyle(fontSize: 15),
                    ),
                    // Text("${f.format(price)}원", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: ElevatedButton(
                            onPressed: () {
                              _url = Uri.parse(
                                  'https://qr.kakaopay.com/FTH8NL7za}');
                              _launchUrl();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFEB03),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "카카오페이 ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "송금",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ))),
                    TextButton(
                        onPressed: () {},
                        child: ElevatedButton(
                            onPressed: () {
                              _url = Uri.parse('https://toss.me/김김김경록');
                              _launchUrl();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3268E8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "토스 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "송금",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ))),
                    TextButton(
                        onPressed: () {},
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                visibility = true;
                                Clipboard.setData(ClipboardData(text: account));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "계좌변호 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "복사",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ))),
                    AnimatedOpacity(
                        opacity: visibility ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: const Text(
                          "클립보드에 계좌번호가 복사되었습니다.",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ))
                  ]),
                ),
              ),
            );
          });
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
        // title: Text(
        //   widget.chat.name,
        //   style: const TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        // ),
        backgroundColor: Colors.white,
      ),
      endDrawer: Drawer(
          child: ListView(children: <Widget>[
        ListTile(
          title: Text('대화상대'),
        ),
        Column(
          children: [
            ListTile(
                leading: Text(
                  "👑",
                  style: TextStyle(fontSize: 25),
                ),
                title: Text("관리자"),
                onTap: () {
                  nextPage(context);
                }),
            ListTile(
                leading: Text(" "),
                title: Text("1"),
                onTap: () {
                  nextPage(context);
                }),
            ListTile(
                leading: Text(" "),
                title: Text("2"),
                onTap: () {
                  nextPage(context);
                }),
          ],
        ),
        Container(
            child: Divider(
          color: Colors.grey,
          thickness: 1.0,
          indent: 20,
          endIndent: 20,
          height: 1,
        )),
        ListTile(
          leading: Icon(CupertinoIcons.money_dollar_circle),
          title: Text("정산하기"),
          onTap: () {
            payModal(context);
          },
        ),
        Container(
            child: Divider(
          color: Colors.grey,
          thickness: 1.0,
          indent: 20,
          endIndent: 20,
          height: 1,
        )),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: Text('방 나가기'),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: Text("나가기"),
                    content: Text("방에서 나가겠습니까?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                        },
                        child: Text("예"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("아니오"),
                      )
                    ],
                  );
                });
          },
        ),
      ])),
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
