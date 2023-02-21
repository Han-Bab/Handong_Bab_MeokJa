import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
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

DateTime now = DateTime.now();
DateFormat formatter = DateFormat('yyyy-M-dd');
String strToday = formatter.format(now);

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
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    getChatandAdmin();
    super.initState();
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

  void modifyInfo(groupName, String orderTime, pick, people) {
    final TextEditingController _restaurantController =
        TextEditingController(text: groupName);
    final _formKey = GlobalKey<FormState>();
    String pickup = pick;
    String maxPeople = people;
    DateTime? time = DateFormat("HH:mm").parse(orderTime);

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        "수정하기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              TextFormField(
                                controller: _restaurantController,
                                decoration: InputDecoration(
                                  hintText: '가게명을 입력해주세요',
                                  iconColor: Colors.black,
                                  labelText: '가게명',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle,
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '가게명을 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DateTimeField(
                                format: DateFormat("HH:mm"),
                                initialValue:
                                    DateFormat("HH:mm").parse(orderTime),
                                decoration: InputDecoration(
                                  hintText: '주문 예정 시간을 설정해주세요',
                                  iconColor: Colors.black,
                                  labelText: '주문 예정 시간',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle,
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                onShowPicker: (context, currentValue) async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.convert(time);
                                },
                                validator: (DateTime? selectedDateTime) {
                                  if (selectedDateTime != null) {
                                    // If the DateTime difference is negative,
                                    // this indicates that the selected DateTime is in the past
                                    var selected = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        selectedDateTime.hour,
                                        selectedDateTime.minute);
                                    if (selected
                                        .difference(DateTime.now())
                                        .isNegative) {
                                      return '이미 지난 시간입니다.';
                                    }
                                  } else {
                                    return '주문 예정 시간을 설정해주세요.';
                                  }
                                },
                                onChanged: (value) {
                                  time = value;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  pickup = value;
                                },
                                initialValue: pickup,
                                decoration: const InputDecoration(
                                  hintText: "예) 비전관, 오석관 등",
                                  labelText: "수령 장소",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '수령할 장소를 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  maxPeople = value;
                                },
                                initialValue: maxPeople,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "예) 2, 3",
                                  labelText: "최대 인원",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '최대 인원을 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("돌아가기"),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        DatabaseService(
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .modifyGroupInfo(
                                                restaurant.groupId,
                                                _restaurantController.text,
                                                DateFormat("HH:mm")
                                                    .format(time!),
                                                pickup,
                                                maxPeople)
                                            .whenComplete(() {
                                          Get.back();
                                          Get.back();
                                          DatabaseService()
                                              .getGroupName(restaurant.groupId)
                                              .then((val) {
                                            setState(() {
                                              print(val);
                                              restaurant.groupName = val;
                                            });
                                          });
                                          DatabaseService()
                                              .getGroupTime(restaurant.groupId)
                                              .then((val) {
                                            setState(() {
                                              restaurant.orderTime = val;
                                            });
                                          });
                                          DatabaseService()
                                              .getGroupPick(restaurant.groupId)
                                              .then((val) {
                                            setState(() {
                                              restaurant.pickup = val;
                                            });
                                          });

                                          Get.snackbar('수정완료!', '채팅방이 수정되었습니다!',
                                              backgroundColor: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        });
                                      }
                                    },
                                    child: const Text("수정하기"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            // 패딩 설정
            constraints: const BoxConstraints(),
            // constraints
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
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
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      const ListTile(
                        title: Text(
                          '방 정보',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text(
                                "가게이름: ",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${restaurant.groupName}",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text(
                                "시간: ",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${restaurant.orderTime}",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text(
                                "픽업장소: ",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${restaurant.pickup}",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 100, right: 100, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            modifyInfo(
                                restaurant.groupName,
                                restaurant.orderTime,
                                restaurant.pickup,
                                restaurant.maxPeople);
                          },
                          child: const Text("수정하기"),
                          style: ButtonStyle(),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 2,
                        endIndent: 2,
                        height: 1,
                      ),
                      const ListTile(
                        title: Text(
                          '대화상대',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: restaurant.members!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (restaurant.members[index] ==
                                      restaurant.admin) {
                                    return ListTile(
                                        leading: Text(
                                          "👑",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        title: Text(
                                            getName(restaurant.members[index]),
                                            style:
                                                const TextStyle(fontSize: 17)));
                                  } else {
                                    return ListTile(
                                      leading: Text(""),
                                      title: Text(
                                          getName(restaurant.members[index]),
                                          style: const TextStyle(fontSize: 17)),
                                    );
                                  }
                                }),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 1.0,
                              indent: 2,
                              endIndent: 2,
                              height: 1,
                            ),
                            ListTile(
                              title: Row(
                                children: const [
                                  Icon(CupertinoIcons.money_dollar_circle),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Text(
                                    "정산하기",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              onTap: () {
                                payModal(context);
                              },
                            ),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 1.0,
                              indent: 2,
                              endIndent: 2,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      "방 나가기",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
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
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid)
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
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )),
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(children: [
              Container(
                alignment: Alignment.topCenter,
                child: Card(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.error_outline,
                            color: Colors.blue[800],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "시간: ${restaurant.orderTime}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "장소: ${restaurant.pickup}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "인원: [${restaurant.currPeople}/${restaurant.maxPeople}]",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1),
                  child: chatMessages(),
                ),
              ),
            ])),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Send a message...",
                  hintStyle: const TextStyle(color: Colors.black26),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      sendMessage();
                    },
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),
        ));
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
                  return Column(
                    children: [
                      snapshot.data.docs[index]['newPerson'] == ""
                          ? MessageTile(
                              message: snapshot.data.docs[index]['message'],
                              sender: snapshot.data.docs[index]['sender'],
                              sentByMe: userName ==
                                  snapshot.data.docs[index]['sender'],
                              time: snapshot.data.docs[index]['time'],
                              recentMessageTime: snapshot.data.docs[index]
                                  ['recentTime'],
                              recentMessageUser: snapshot.data.docs[index]
                                  ['recentUser'])
                          : snapshot.data.docs[index]['inOut'] == "in" ?
                      Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[300],
                              ),
                              child: Text(
                                "${getName(snapshot.data.docs[index]['newPerson'])}님이 입장하였습니다.",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ) : Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[300],
                        ),
                        child: Text(
                          "${getName(snapshot.data.docs[index]['newPerson'])}님이 퇴장하였습니다.",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  );
                })
            : Container();
      },
    );
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      DocumentReference d = FirebaseFirestore.instance
          .collection("groups")
          .doc(restaurant.groupId);
      DocumentSnapshot documentSnapshot = await d.get();
      var sender = documentSnapshot['recentMessageSender'];
      var time = documentSnapshot['recentMessageTime'];

      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userName,
        "time": DateFormat("yyyy-M-dd a h:mm:ss", "ko").format(DateTime.now()),
        "recentTime": time,
        "recentUser": sender,
        "newPerson": ""
      };
      DatabaseService().sendMessage(restaurant.groupId, chatMessageMap);
      messageController.clear();
    }
  }
}
