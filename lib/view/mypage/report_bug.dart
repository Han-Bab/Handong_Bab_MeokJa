import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/mypage_controller.dart';

class ReportBug extends StatelessWidget {
  ReportBug({Key? key}) : super(key: key);

  final mypageController = Get.put(MypageController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "불편하신 점이 있으신가요?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                '이용 중 불편한 점이나 문의 사항을 알려주세요!',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                '확인 후 신속 정확하게 답변 드리도록 하겠습니다 :)',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                '평일 (월-금) 10:00 ~ 18:00, 주말 및 공휴일 휴무',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: const BorderSide(width: 0.5),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    mypageController.sendEmail();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("이메일 보내기"),
                      Icon(CupertinoIcons.chevron_forward),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
