import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'main_screen.dart';

List _data = [
  {
    'id': 1,
    'name': '류앤돈까스',
    'image': 'assets/images/1.jpg',
    'user': 'aa',
    'date': '2023/01/02',
    'time': '17:00',
    'curr_people': 1,
    'max_people': 4
  },
  {
    'id': 2,
    'name': '동궁찜닭',
    'image': 'assets/images/2.jpg',
    'user': 'bb',
    'date': '2023/01/06',
    'time': '13:00',
    'curr_people': 2,
    'max_people': 4
  },
  {
    'id': 3,
    'name': '꼬꼬뽀끼',
    'image': 'assets/images/3.jpg',
    'user': 'cc',
    'date': '2023/01/01',
    'time': '17:00',
    'curr_people': 4,
    'max_people': 4
  },
  {
    'id': 4,
    'name': 'bbq',
    'image': 'assets/images/4.jpg',
    'user': 'dd',
    'date': '2022/12/11',
    'time': '17:00',
    'curr_people': 3,
    'max_people': 4
  },
  {
    'id': 5,
    'name': '행복한 마라탕',
    'image': 'assets/images/5.jpg',
    'user': 'ee',
    'date': '2022/11/01',
    'time': '17:00',
    'curr_people': 2,
    'max_people': 3
  },
  {
    'id': 6,
    'name': '삼촌네',
    'image': 'assets/images/6.jpg',
    'user': 'ff',
    'date': '2022/12/19',
    'time': '17:00',
    'curr_people': 1,
    'max_people': 2
  },
  {
    'id': 7,
    'name': '신전 떡볶이',
    'image': 'assets/images/7.jpg',
    'user': 'gg',
    'date': '2023/01/08',
    'time': '17:00',
    'curr_people': 2,
    'max_people': 4
  },
  {
    'id': 8,
    'name': '명성',
    'image': 'assets/images/8.jpg',
    'user': 'hh',
    'date': '2023/01/09',
    'time': '17:00',
    'curr_people': 1,
    'max_people': 4
  },
  {
    'id': 9,
    'name': '땅땅치킨',
    'image': 'assets/images/9.jpg',
    'user': 'ii',
    'date': '2022/10/02',
    'time': '17:00',
    'curr_people': 1,
    'max_people': 4
  },
  {
    'id': 10,
    'name': '행복한 마라탕',
    'image': 'assets/images/10.jpg',
    'user': 'jj',
    'date': '2023/01/05',
    'time': '17:00',
    'curr_people': 1,
    'max_people': 4
  },
];

void nextPage(context, user, image, description) {
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


class GroupListViewDemo extends StatelessWidget {
  const GroupListViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero, // 패딩 설정
          constraints: const BoxConstraints(), // constraints
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainScreen()));
          },
          icon: const Icon(Icons.arrow_back),
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
      body: GroupedListView<dynamic, String>(
          elements: _data,
          groupBy: (item) {
            var now = new DateTime.now();
            String date = "오래전";
            String formatDate = DateFormat('yyyy/MM/dd').format(now);
            if (item['date'] == formatDate) date = "오늘";
            var yesterday = new DateTime(now.year, now.month, now.day - 1);
            formatDate = DateFormat('yyyy/MM/dd').format(yesterday);
            if (item['date'] == formatDate) date = "어제";
            for (int i = 2; i <= 31; i++) {
              var week = new DateTime(now.year, now.month, now.day - i);
              formatDate = DateFormat('yyyy/MM/dd').format(week);
              if (item['date'] == formatDate) {
                if (i >= 2 && i <= 7) date = "일주일전";
                if (i > 7 && i <= 31) date = "한달전";
              }
            }
            return date;
          },
          order: GroupedListOrder.ASC,
          groupComparator: ((a,b){
            int x =0,y=0;
            if(a == "오래전") x = 4;
            else if(a == "한달전") x = 3;
            else if(a == "일주일전") x = 2;
            else if(a == "어제") x = 1;
            else if(a == "오늘") x = 0;
            if(b == "오래전") y = 4;
            else if(b == "한달전") y = 3;
            else if(b == "일주일전") y = 2;
            else if(b == "어제") y = 1;
            else if(b == "오늘") y = 0;
            return x-y;
          }),
        groupSeparatorBuilder: (groupValue) => Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        groupValue,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    Expanded(
                      child: Divider(color: Colors.red),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        itemBuilder: (context, item) {
          return GestureDetector(
            onTap: () {
              debugPrint(item['name']);
              nextPage(context, item['name'], item['image'], item['user']);
            },
            child: Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 100,
                          height: 80,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Image.asset(
                              item['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      item['time'],
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.account_circle_sharp,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text('${item['user']}'),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Text('${item['date']}'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 5),
                                    child: Row(
                                      children: [
                                        const Icon(CupertinoIcons.person),
                                        Text(
                                            '${item['curr_people']}/${item['max_people']}'),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
        itemComparator: (item1, item2) =>
            item1['date'].compareTo(item2['date']),
        useStickyGroupSeparators: true,
        floatingHeader: false,
      ),
    );
  }
}
