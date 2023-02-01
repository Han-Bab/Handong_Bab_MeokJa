import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../community/content.dart';
import '../community/plus_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  var titleList = [
    '양덕 맛집',
    '방학에 학교에 남는 사람?',
    '1월 2일 새벽 감사',
    '도와주세요',
    '수강 신청 교환 기간',
    '일생 한국어 분반',
    '오늘 오석',
    '겨울 나비',
    '원룸 양도',
    '점메추'
  ];

  List<int> heart = [51, 0, 11, 7, 3, 1, 5, 88, 1, 14];

  var content = [
    '추천해 주세요',
    '물어볼 거 있음',
    '맛있는 밥을 먹게 해주셔서 감사합니다!',
    '이 친구 왜 안 되는 거죠ㅠㅠ',
    '언제까지인지 아시는 분?',
    '정원 몇 명이야?',
    '열었나요?',
    '는 넘무 귀엽다',
    '문의 주세요',
    'ㅈㄱㄴ'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '음식게시판',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2, // 경계선 없애는 늒임
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: titleList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Content()),
                  );
                },
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: SizedBox(
                                width: width * 0.9,
                                child: Text(
                                  titleList[index],
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.7,
                                  child: Text(
                                    content[index],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Row(
                                    children: [
                                      LikeButton(
                                        size: 25,
                                        likeCount: heart[index],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      LikeButton(
                                        size: 25,
                                        likeCount: 0,
                                        likeBuilder: (isTapped) {
                                          return Icon(
                                            Icons.chat_bubble_outline_outlined,
                                            color: isTapped
                                                ? Colors.black54
                                                : Colors.grey,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
        Positioned(
          bottom: 20,
          child: SizedBox(
            width: width,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlusPage()),
                  );
                },
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  '글 쓰기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
