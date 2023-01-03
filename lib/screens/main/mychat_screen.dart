import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/screens/main/main_screen.dart';

List _data = [
  {
    'id' : 1,
    'user' : 'aa',
    'image' : 'assets/images/1.jpg',
    'name' : '류앤돈까스',
    'time' : '17:00',
    'curr_people' : 1,
    'max_people' : 4
  },
  {
    'id' : 2,
    'user' : 'bb',
    'image' : 'assets/images/2.jpg',
    'name' : '동굼찜닭',
    'time' : '13:00',
    'curr_people' : 2,
    'max_people' : 4
  },
  {
    'id' : 3,
    'user' : 'cc',
    'image' : 'assets/images/3.jpg',
    'name' : '꼬꼬뽀끼',
    'time' : '17:00',
    'curr_people' : 4,
    'max_people' : 4
  },
  {
    'id' : 4,
    'user' : 'dd',
    'image' : 'assets/images/4.jpg',
    'name' : 'bbq',
    'time' : '17:00',
    'curr_people' : 3,
    'max_people' : 4
  },
  {
    'id' : 5,
    'user' : 'ee',
    'image' : 'assets/images/5.jpg',
    'name' : '행복한 마라탕',
    'time' : '17:00',
    'curr_people' : 2,
    'max_people' : 3
  },
  {
    'id' : 6,
    'user' : 'ff',
    'image' : 'assets/images/6.jpg',
    'name' : '삼촌네',
    'time' : '17:00',
    'curr_people' : 1,
    'max_people' : 2
  },
  {
    'id' : 7,
    'user' : 'gg',
    'image' : 'assets/images/7.jpg',
    'name' : '신전 떡볶이',
    'time' : '17:00',
    'curr_people' : 2,
    'max_people' : 4
  },
  {
    'id' : 8,
    'user' : 'hh',
    'image' : 'assets/images/8.jpg',
    'name' : '류앤돈까스',
    'time' : '17:00',
    'curr_people' : 1,
    'max_people' : 4
  },
  {
    'id' : 9,
    'user' : 'ii',
    'image' : 'assets/images/9.jpg',
    'name' : '류앤돈까스',
    'time' : '17:00',
    'curr_people' : 1,
    'max_people' : 4
  },
  {
    'id' : 10,
    'user' : 'aa',
    'image' : 'assets/images/10.jpg',
    'name' : '류앤돈까스',
    'time' : '17:00',
    'curr_people' : 1,
    'max_people' : 4
  },
];

final userList = ['aa', 'bb', 'cc', 'dd', 'ee', 'ff', 'gg', 'hh', 'ii', 'jj'];
final nameList = [
  '류앤돈까스',
  '동궁찜닭',
  '꼬꼬뽀끼',
  'bbq',
  '행복한 마라탕',
  '삼촌네?',
  '신전 떡볶이',
  '명성',
  '땅땅치킨',
  '행복한 마라탕'
];
final time = [
  '17:00',
  '14:00',
  '13:20',
  '11:30',
  '15:30',
  '18:00',
  '21:00',
  '23:00',
  '13:00',
  '12:00'
];
final description = [
  '1/4',
  '2/4',
  '3/4',
  '4/4',
  '1/4',
  '2/4',
  '3/4',
  '4/4',
  '1/2',
  '1/3'
];
final imageList = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/5.jpg',
  'assets/images/6.jpg',
  'assets/images/7.jpg',
  'assets/images/8.jpg',
  'assets/images/9.jpg',
  'assets/images/10.jpg'
];

void nextPage(context, title, image, description) {
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
          ),
        );
      });
}

int person = 0;
int maxPeople = 4;

class MyChat extends StatelessWidget {
  const MyChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero, // 패딩 설정
          constraints: BoxConstraints(), // constraints
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainScreen()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text(
          "주문내역",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: nameList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint(nameList[index]);
              nextPage(context, nameList[index], imageList[index],
                  description[index]);
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        imageList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), //image
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userList[index],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Text(time[index]),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              nameList[index],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              " ❯",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    const Icon(CupertinoIcons.person),
                                    Text('$person/$maxPeople'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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

