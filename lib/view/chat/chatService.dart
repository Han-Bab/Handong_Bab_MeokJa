import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main/main_screen.dart';

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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextButton(
                      child: Image.asset("assets/images/kakao.png"),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

class ChatService extends StatelessWidget {
  const ChatService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "설정",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "방 나가기",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()));
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
                  ListTile(
                    title: const Text(
                      "정산하기",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      nextPage(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '토스트 테스트',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
