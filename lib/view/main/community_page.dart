import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../community//content.dart';
import '../community//pluspage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  var titleList = [
    '기이 성적',
    '방학에 학교에 남는 사람?',
    '1월 2일 새벽 감사',
    '도와주세요',
    '성적정정기간',
    '일생 한국어 분반',
    '오늘 오석',
    '겨울 나비',
    '원룸 양도',
    '점메추'
  ];

  var heart = ['1', '2', '1', '5', '18', '0', '9', '10', '54', '4'];

  var content = [
    '진짜 대체 언제 나옴',
    '물어볼 거 있어요',
    '맛있는 밥을 먹게 해주셔서 감사합니다!',
    '이 친구 왜 안 되는 거죠ㅠㅠ',
    '언제까지인지 아시는 분?',
    '왜 점수 안 나오나요!?',
    '열었나요?',
    '는 넘무 귀엽다',
    '문의 주세요',
    'ㅈㄱㄴ'
  ];

  void showPopup(context, title, content) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '자유게시판',
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
                    MaterialPageRoute(builder: (context) => Content()),
                  );
                  //showPopup(context, titleList[index], content[index]);
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => ),
                  // );
                },
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width + 40,
                              child: Text(
                                titleList[index],
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width - 20,
                                  height: 20,
                                  child: Text(
                                    content[index],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  //width: 30,
                                  //margin: EdgeInsets.only(right: 10),
                                  //padding: const EdgeInsets.only(),
                                  child: Row(
                                    children: const [
                                      LikeButton(
                                        size: 20,
                                        likeCount: 0,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 5,
                                ),
                                SizedBox(
                                  //width: 5,
                                  //margin: EdgeInsets.only(left: 5),
                                  //padding: const EdgeInsets.only(),
                                  child: Row(
                                    children: const [
                                      LikeButton(
                                        size: 20,
                                        likeCount: 0,
                                      )
                                      // const Icon(CupertinoIcons.heart),
                                      // Text(
                                      //   heart[index],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      // 여기에 좋아요랑 댓글 수 이런 거 착성하면 되겠다.
                    ],
                  ),
                ));
          },
        ),
        Positioned(
          bottom: 20,
          left: 150,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlusPage()),
              );
            },
            style: TextButton.styleFrom(
                primary: Colors.black, backgroundColor: Colors.grey),
            child: const Text(
              '글 쓰기',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ]),
    );
  }
}
