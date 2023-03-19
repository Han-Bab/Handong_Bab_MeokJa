import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/chat_info_controller.dart';
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
  final chatInfoController = Get.put(ChatInfoController());

  @override
  initState() {
    getChatandAdmin();
    super.initState();
    chatInfoController.setInfo(
        restaurant.groupName,
        restaurant.orderTime,
        restaurant.pickup,
        restaurant.currPeople,
        restaurant.maxPeople,
        restaurant.members);
    print(chatInfoController.restaurantName.value);
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

  noBaeMin(context, groupName) {
    DatabaseService().baeMinPhoneNumber(groupName).then((phoneNumber) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "배민에 등록되어",
                      style: TextStyle(color: Color(0xff3E3E3E), fontSize: 20),
                    ),
                    const Text(
                      "있지 않은 가게입니다.",
                      style: TextStyle(color: Color(0xff3E3E3E), fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "전화번호: ",
                      style: TextStyle(color: Color(0xff3E3E3E), fontSize: 15),
                    ),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                          color: Color(0xff3E3E3E), fontSize: 15),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "확인",
                          style:
                              TextStyle(color: Color(0xff75B165), fontSize: 18),
                        ))
                  ],
                ),
              ),
            );
          });
    });
  }

  roomOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: const EdgeInsets.only(top: 20.0),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "방에서 나가시겠습니까?",
                    style: TextStyle(
                        color: Color(0xff3E3E3E),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "취소",
                          style:
                              TextStyle(color: Color(0xffED6160), fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
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
                                  chatInfoController.restaurantName.value);

                          Get.to(() => MainScreen());
                        },
                        child: const Text(
                          "확인",
                          style:
                              TextStyle(color: Color(0xff75B165), fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> payModal(context) async {
    bool visibility = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: const EdgeInsets.only(top: 3.0),
            content: StatefulBuilder(builder: (context, setState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.33,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "×",
                            style: TextStyle(
                                color: Color(0xff717171), fontSize: 40),
                          ))
                    ],
                  ),
                  Text(
                    getName(restaurant.admin),
                    style: const TextStyle(
                        color: Color(0xff3E3E3E),
                        fontSize: 23,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          _url =
                              Uri.parse('https://qr.kakaopay.com/FTH8NL7za}');
                          _launchUrl();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFEB03),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          _url = Uri.parse('https://toss.me/김김김경록');
                          _launchUrl();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3268E8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "토스페이 ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "송금",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ),
                  AnimatedOpacity(
                      opacity: visibility ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "클립보드에 계좌번호가 복사되었습니다.",
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ))
                ]),
              );
            }),
          );
        });
  }

  void modifyInfo(groupName, String orderTime, pick, people) {
    final TextEditingController restaurantController =
        TextEditingController(text: groupName);
    final formKey = GlobalKey<FormState>();
    String pickup = pick;
    String maxPeople = people;
    DateTime? time = DateFormat("HH:mm").parse(orderTime);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding:
                const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
            content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.48,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        "수정하기",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Form(
                          key: formKey,
                          child: ListView(
                            children: [
                              TextFormField(
                                controller: restaurantController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  border: UnderlineInputBorder(),
                                  fillColor: Colors.white,
                                  hintText: '가게명을 입력해주세요',
                                  iconColor: Colors.black,
                                  labelText: '가게명',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '가게명을 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DateTimeField(
                                format: DateFormat("HH:mm"),
                                initialValue:
                                    DateFormat("HH:mm").parse(orderTime),
                                decoration: const InputDecoration(
                                  hintText: '주문 예정 시간을 설정해주세요',
                                  iconColor: Colors.black,
                                  labelText: '주문 예정 시간',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  border: UnderlineInputBorder(),
                                  fillColor: Colors.white,
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
                                height: 20,
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
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  border: UnderlineInputBorder(),
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '수령할 장소를 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
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
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  border: UnderlineInputBorder(),
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '최대 인원을 입력하세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "취소",
                                      style:
                                          TextStyle(color: Color(0xffED6160)),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        DatabaseService(
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .modifyGroupInfo(
                                                restaurant.groupId,
                                                groupName,
                                                restaurantController.text,
                                                DateFormat("HH:mm")
                                                    .format(time!),
                                                pickup,
                                                maxPeople)
                                            .whenComplete(() {
                                          Get.back();
                                          Get.back();
                                          chatInfoController.setInfo(
                                              restaurantController.text,
                                              DateFormat("HH:mm").format(time!),
                                              pickup,
                                              restaurant.currPeople,
                                              maxPeople,
                                              restaurant.members);
                                          Get.snackbar('수정완료!', '채팅방이 수정되었습니다!',
                                              backgroundColor: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        });
                                      }
                                    },
                                    child: const Text(
                                      "수정",
                                      style:
                                          TextStyle(color: Color(0xff75B165)),
                                    ),
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
          title: Obx(
            () => Text(
              chatInfoController.restaurantName.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size(50, 50),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE1E1E1)),
                  color: const Color(0xffFEFEFE)),
              margin: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xff75B165),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            const Text(
                              "시간: ",
                              style: TextStyle(
                                  color: Color(0xff717171), fontSize: 13),
                            ),
                            Text(
                              "${chatInfoController.orderTime.value}분",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 25),
                      Obx(
                        () => Row(
                          children: [
                            const Text(
                              "장소: ",
                              style: TextStyle(
                                  color: Color(0xff717171), fontSize: 13),
                            ),
                            Text(
                              chatInfoController.pickUp.value,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            const Text(
                              "인원: ",
                              style: TextStyle(
                                  color: Color(0xff717171), fontSize: 13),
                            ),
                            Text(
                              "${chatInfoController.currPeople.value}/${chatInfoController.maxPeople.value}명",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        endDrawer: Drawer(
            child: Column(
          children: [
            Expanded(
              child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            const Text(
                              '방 정보',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            getName(restaurant.admin) == userName
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.create,
                                      color: Colors.black,
                                      size: 23,
                                    ),
                                    onPressed: () {
                                      modifyInfo(
                                          chatInfoController
                                              .restaurantName.value,
                                          chatInfoController.orderTime.value,
                                          chatInfoController.pickUp.value,
                                          chatInfoController.maxPeople.value);
                                    })
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.0,
                      indent: 0,
                      endIndent: 0,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            const Text(
                              "가게명: ",
                              style: TextStyle(fontSize: 17),
                            ),
                            Obx(
                              () => Text(
                                chatInfoController.restaurantName.value,
                                style: const TextStyle(fontSize: 17),
                              ),
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
                              style: TextStyle(fontSize: 17),
                            ),
                            Obx(
                              () => Text(
                                chatInfoController.orderTime.value,
                                style: const TextStyle(fontSize: 17),
                              ),
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
                              style: TextStyle(fontSize: 17),
                            ),
                            Obx(
                              () => Text(
                                chatInfoController.pickUp.value,
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: ListTile(
                        title: Text(
                          '대화상대',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.0,
                      indent: 0,
                      endIndent: 0,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          Obx(
                            () => ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    chatInfoController.member.value!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          String.fromCharCode(
                                              CupertinoIcons.person.codePoint),
                                          style: TextStyle(
                                            inherit: false,
                                            color: const Color(0xff717171),
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: CupertinoIcons
                                                .person.fontFamily,
                                            package: CupertinoIcons
                                                .person.fontPackage,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 13,
                                        ),
                                        Text(
                                            getName(chatInfoController
                                                .member.value[index]),
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        const SizedBox(
                                          width: 13,
                                        ),
                                        chatInfoController
                                                    .member.value[index] ==
                                                restaurant.admin
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                      top: 6.0,
                                                      bottom: 6.0),
                                                  child: Text(
                                                    "방장",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  );
                                }
                                // }
                                ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1.0,
                            indent: 0,
                            endIndent: 0,
                            height: 1,
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Image.asset(
                                  "assets/images/coin.png",
                                  scale: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "정산하기",
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xff3E3E3E)),
                                ),
                              ],
                            ),
                            onTap: () {
                              payModal(context);
                            },
                          ),
                          ListTile(
                              title: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/baemin.png",
                                    scale: 1.8,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "배민 바로가기",
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xff39C0C0)),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatabaseService()
                                    .baeMinUrl(
                                        chatInfoController.restaurantName.value)
                                    .then((url) {
                                  _url = Uri.parse(url);
                                  if (url == "") {
                                    return noBaeMin(
                                        context,
                                        chatInfoController
                                            .restaurantName.value);
                                  } else {
                                    return _launchUrl();
                                  }
                                });
                              }),
                        ],
                      ),
                    ),
                  ]),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/out.png",
                      scale: 2,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "방 나가기",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              onTap: () {
                roomOut();
              },
            ),
            const SizedBox(
              height: 60,
            )
          ],
        )),
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height * 0.1),
                  child: chatMessages(),
                ),
              ),
            ])),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 49.0, left: 24, right: 24),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(-5, 5),
                  ),
                ],
              ),
              child: TextFormField(
                controller: messageController,
                maxLines: null,
                scrollPhysics: const ClampingScrollPhysics(),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "메시지를 입력하세요",
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontSize: 14, height: 2.7),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Image.asset(
                        "assets/up.png",
                        scale: 2,
                      )),
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
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
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
                          : snapshot.data.docs[index]['inOut'] == "in"
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.only(
                                      top: 7, bottom: 7, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffF1F1F1),
                                  ),
                                  child: Text(
                                    "${getName(snapshot.data.docs[index]['newPerson'])}님이 입장하셨습니다.",
                                    style: const TextStyle(
                                        color: Color(0xff717171), fontSize: 12),
                                  ),
                                )
                              : snapshot.data.docs[index]['inOut'] == "out"
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.only(
                                          top: 7, bottom: 7, left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffF1F1F1),
                                      ),
                                      child: Text(
                                        "${getName(snapshot.data.docs[index]['newPerson'])}님이 퇴장하셨습니다.",
                                        style: const TextStyle(
                                            color: Color(0xff717171),
                                            fontSize: 12),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.only(
                                          top: 7, bottom: 7, left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffF1F1F1),
                                      ),
                                      child: const Text(
                                        "방 정보가 수정되었습니다.",
                                        style: TextStyle(
                                            color: Color(0xff717171),
                                            fontSize: 12),
                                      ),
                                    )
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
