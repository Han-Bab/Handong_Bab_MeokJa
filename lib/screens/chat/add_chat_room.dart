import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddChatRoom extends StatefulWidget {
  const AddChatRoom({Key? key}) : super(key: key);

  @override
  State<AddChatRoom> createState() => _AddChatRoomState();
}

class _AddChatRoomState extends State<AddChatRoom> {
  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _maxPeopleController = TextEditingController();
  String orderTime = "주문 예정 시간을 설정해주세요";
  String accountNumber = "1002-452-023325 우리";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "밥채팅 만들기",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  DottedBorder(
                    child: Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/chef.gif'),
                        ),
                      ),
                    ),
                    color: Colors.grey,
                    dashPattern: [5, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _restaurantController,
                          decoration: InputDecoration(
                            hintText: '가게명을 입력해주세요',
                            icon: const Icon(CupertinoIcons.search),
                            iconColor: Colors.black,
                            labelStyle: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle,
                            hintStyle: Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text("주문 예정 시간"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // 주문 예정 시간 설정하기
                                  Future<TimeOfDay?> selectedTime =
                                      showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  int? hour;
                                  int? minute;
                                  selectedTime.then((timeOfDay) {
                                    hour = timeOfDay?.hour;
                                    minute = timeOfDay?.minute;
                                    hour ??= TimeOfDay.now().hour;
                                    minute ??= TimeOfDay.now().minute;
                                    setState(() {
                                      orderTime = "$hour : $minute";
                                    });
                                  });
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  orderTime,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(accountNumber),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0)),
                              child: const Text(
                                "계좌 변경",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("최대 인원"),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: width * 0.25,
                              child: TextField(
                                controller: _maxPeopleController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 110,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("취소"),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text("확인"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
