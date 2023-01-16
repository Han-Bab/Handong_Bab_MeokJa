import 'package:flutter/material.dart';

class PrivacyTerm extends StatelessWidget {
  const PrivacyTerm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
        child: Column(
          children: [
            const Text(
              "개인정보 수집 및 이용 동의",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 50,
            ),
            Text(
              "'한밥'은 개인정보를 안전하게 취급하는데 최선을 다합니다.\n아래에 동의하시면 계정의 프로필정보를 '한밥'이 제공하는 서비스에서 편리하게 이용하실 수 있습니다.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
