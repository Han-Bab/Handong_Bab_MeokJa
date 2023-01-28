import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/order_time_button_controller.dart';
import 'package:han_bab/model/order_time_button.dart';
import 'package:han_bab/view/main/main_screen.dart';

class AddChatRoom extends StatelessWidget {
  AddChatRoom({Key? key}) : super(key: key);

  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _maxPeopleController = TextEditingController();

  String accountNumber = "1002-452-023325 우리";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTimeButtonController());
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
              padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
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
                    dashPattern: const [5, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
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
                            labelText: '가게명',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle,
                            hintStyle: Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle,
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text("주문 예정 시간"),
                            SizedBox(
                              width: 10,
                            ),
                            // OrderTimeButton
                            Expanded(child: OrderTimeButton()),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: null,
                                child: Text(
                                  accountNumber,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey),
                                ),
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
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "예) 비전관, 오석관 등",
                                  labelText: "수령 장소",
                                  contentPadding: EdgeInsets.all(10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _maxPeopleController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "예) 4명 등",
                                  labelText: "최대 인원",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.off(MainScreen());
                                },
                                child: const Text("취소하기"),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.off(() => MainScreen());
                                },
                                child: const Text("생성하기"),
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
