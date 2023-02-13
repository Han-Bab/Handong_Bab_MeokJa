import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPW extends StatelessWidget {
  const ResetPW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emailAddr = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 재설정'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onChanged: (value) {
                emailAddr = value;
              },
              decoration: const InputDecoration(
                hintText: '한동 이메일을 입력해주세요',
                hintStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                emailAddr = value;
              },
              decoration: const InputDecoration(
                hintText: '이름을 입력해주세요',
                hintStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("재설정 메일 보내기"),
            ),
          ],
        ),
      ),
    );
  }
}
