import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:han_bab/view/chat/message_tile.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/database_service.dart';
import '../main/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var restaurant = Get.arguments;
  late Uri _url;
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  String userName = "";
  StreamController<bool> streamController = StreamController<bool>();
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    getChatandAdmin();
    super.initState();
    initializeDateFormatting("ko", null);
  }

  getChatandAdmin() {
    DatabaseService().getChats(restaurant.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(restaurant.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
    DatabaseService().getUserName().then((val) {
      setState(() {
        userName = val;
      });
    });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  Future<void> payModal(context) async {
    bool visibility = false;
    var result = await FirebaseFirestore.instance
        .collection('user')
        .doc(getId(restaurant.admin))
        .get();
    String account = result['userAccount'];
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
                    Text(
                      getName(restaurant.admin),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      account,
                      style: const TextStyle(fontSize: 15),
                    ),
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
            padding: EdgeInsets.zero,
            // 패딩 설정
            constraints: const BoxConstraints(),
            // constraints
            onPressed: () {
              Get.offAll(() => MainScreen());
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            restaurant.groupName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        endDrawer: Drawer(
            child: ListView(children: <Widget>[
          const ListTile(
            title: Text(
              '방 정보',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("가게이름: ${restaurant.groupName}"),
          ),
          ListTile(
            title: Text("시간: ${restaurant.orderTime}"),
          ),
          ListTile(
            title: Text("픽업장소: ${restaurant.pickup}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100, bottom: 10),
            child: ElevatedButton(onPressed: () {}, child: const Text("수정하기"), style: ButtonStyle(),),
          ),
          Container(
              child: Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 20,
            endIndent: 20,
            height: 1,
          )),
          const ListTile(
            title: Text(
              '대화상대',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: restaurant.members!.length,
              itemBuilder: (BuildContext context, int index) {
                if (restaurant.members[index] == restaurant.admin) {
                  return ListTile(
                      leading: Text(
                        "👑",
                        style: TextStyle(fontSize: 25),
                      ),
                      title: Text(getName(restaurant.members[index])));
                } else {
                  return ListTile(
                    leading: Text(""),
                    title: Text(getName(restaurant.members[index])),
                  );
                }
              }),
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
                          onPressed: () async {
                            var result = await FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get();
                            String userName = result['userName'];
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .groupOut(restaurant.groupId, userName,
                                    restaurant.groupName);

                            Get.to(() => MainScreen());
                          },
                          child: Text("예"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("아니오"),
                        )
                      ],
                    );
                  });
            },
          ),
        ])),
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: chatMessages(),
            )),
        bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[700],
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  maxLines: null,
                  controller: messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  inOut() {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[300],
                ),
                width: MediaQuery.of(context).size.width - 10,
                height: 28,
                child: Center(
                    child: Text(
                  "${getName(restaurant.members[restaurant.members.length - 1])}님이 입장하였습니다.",
                  style: const TextStyle(color: Colors.white),
                )),
              )
            : Container();
      },
    );
  }

  bool _needsScroll = false;

  _scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  _needsScroll = true;
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: userName == snapshot.data.docs[index]['sender'],
                      time: snapshot.data.docs[index]['time']);
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userName,
        "time": DateFormat("a h:mm:ss", "ko").format(DateTime.now()),
      };
      DatabaseService().sendMessage(restaurant.groupId, chatMessageMap);
      messageController.clear();
    }
  }
}
