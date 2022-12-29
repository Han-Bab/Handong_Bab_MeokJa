import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../chat/chatRoom_screen.dart';
import 'main_screen.dart';
import '../chat/model.dart';

// List _data = [
//   {
//     'id': 1,
//     'user': 'aa',
//     'image': 'assets/images/1.jpg',
//     'name': '류앤돈까스',
//     'time': '17:00',
//     'curr_people': 1,
//     'max_people': 4
//   },
//   {
//     'id': 2,
//     'user': 'bb',
//     'image': 'assets/images/2.jpg',
//     'name': '동굼찜닭',
//     'time': '13:00',
//     'currPeople': 2,
//     'maxPeople': 4
//   },
//   {
//     'id': 3,
//     'user': 'cc',
//     'image': 'assets/images/3.jpg',
//     'name': '꼬꼬뽀끼',
//     'time': '17:00',
//     'currPeople': 4,
//     'maxPeople': 4
//   },
//   {
//     'id': 4,
//     'user': 'dd',
//     'image': 'assets/images/4.jpg',
//     'name': 'bbq',
//     'time': '17:00',
//     'currPeople': 3,
//     'maxPeople': 4
//   },
//   {
//     'id': 5,
//     'user': 'ee',
//     'image': 'assets/images/5.jpg',
//     'name': '행복한 마라탕',
//     'time': '17:00',
//     'currPeople': 2,
//     'maxPeople': 3
//   },
//   {
//     'id': 6,
//     'user': 'ff',
//     'image': 'assets/images/6.jpg',
//     'name': '삼촌네',
//     'time': '17:00',
//     'currPeople': 1,
//     'maxPeople': 2
//   },
//   {
//     'id': 7,
//     'user': 'gg',
//     'image': 'assets/images/7.jpg',
//     'name': '신전 떡볶이',
//     'time': '17:00',
//     'currPeople': 2,
//     'maxPeople': 4
//   },
//   {
//     'id': 8,
//     'user': 'hh',
//     'image': 'assets/images/8.jpg',
//     'name': '명성',
//     'time': '17:00',
//     'currPeople': 1,
//     'maxPeople': 4
//   },
//   {
//     'id': 9,
//     'user': 'ii',
//     'image': 'assets/images/9.jpg',
//     'name': '땅땅치킨',
//     'time': '17:00',
//     'currPeople': 1,
//     'maxPeople': 4
//   },
//   {
//     'id': 10,
//     'user': 'jj',
//     'image': 'assets/images/10.jpg',
//     'name': '행복한 마라탕',
//     'time': '17:00',
//     'currPeople': 1,
//     'maxPeople': 4
//   },
// ];

final List<String> userList = [
  'aa',
  'bb',
  'cc',
  'dd',
  'ee',
  'ff',
  'gg',
  'hh',
  'ii',
  'jj'
];
final List<String> nameList = [
  '류앤돈까스',
  '동궁찜닭',
  '꼬꼬뽀끼',
  'bbq',
  '행복한 마라탕',
  '삼촌네',
  '신전 떡볶이',
  '명성',
  '땅땅치킨',
  '행복한 마라탕'
];
final List<String> time = [
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
final List<String> date = [
  '2023/01/02',
  '2022/12/28',
  '2023/01/01',
  '2022/12/11',
  '2022/11/01',
  '2022/12/19',
  '2022/12/20',
  '2022/12/14',
  '2022/10/02',
  '2022/10/10'
];
final List<int> currPeople = [1, 2, 3, 4, 1, 2, 3, 4, 1, 2];
final List<int> maxPeople = [3, 4, 3, 4, 3, 4, 3, 4, 3, 4];
final List<String> imageList = [
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

final List<Chat> chatData = List.generate(
    imageList.length,
    (index) => Chat(imageList[index], userList[index], nameList[index],
        date[index], time[index], currPeople[index], maxPeople[index]));

DateTime now = DateTime.now();
String currHour = DateFormat("HH").format(now);
String currMinute = DateFormat("mm").format(now);


var flag1 = List.empty(growable: true);
int j=0;
int TimeOutCount () {
  int count = 0;
  for(int i=0; i<chatData.length; i++) {
    if((int.parse(chatData[i].time.substring(0,2))>int.parse(currHour))||
        ((int.parse(chatData[i].time.substring(0,2))==int.parse(currHour))&&(int.parse(chatData[i].time.substring(3,5))>int.parse(currMinute)))){
      count++;
    }
  }
  return count;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Flexible(
            child: Card(
              child: OutlinedButton.icon(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                label: Text("Search"),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size(420, 0),
                  side: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
        backgroundColor: Colors.white70,
        elevation: 0, //appbar 경계선
      ),
      body: ListView.builder(
        itemCount: TimeOutCount(),
        itemBuilder: (context, index) {
          for(int i=0; i<chatData.length; i++) {
            if((int.parse(chatData[i].time.substring(0,2))>int.parse(currHour))||
                ((int.parse(chatData[i].time.substring(0,2))==int.parse(currHour))&&(int.parse(chatData[i].time.substring(3,5))>int.parse(currMinute)))){
              flag1.add(i);
            }
          }
          index = flag1[j];
          //print("index ${index}");
          j++;
          return GestureDetector(
            onTap: () {
<<<<<<< Updated upstream
              debugPrint(nameList[index]);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatRoom(
                        chat: chatData[index],
                      )));
=======
              if(chatData[index].currPeople != chatData[index].maxPeople) {
                  debugPrint(chatData[index].name);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatRoom(chat: chatData[index],)));
              }else{
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext ctx){
                      return AlertDialog(
                        title: Text("정원초과"),
                        content: Text("인원이 마감되었습니다."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("확인"),
                          ),
                        ],
                      );
                    }
                );
              }
>>>>>>> Stashed changes
            },
            child: Card(
              color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.grey : Colors.white,
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
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle_sharp,
                                  color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.black : Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  chatData[index].user,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(chatData[index].time),
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
                              chatData[index].name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            if(chatData[index].currPeople != chatData[index].maxPeople)
                              const Text(
                                " ❯",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                            else
                              const Text(
                                " ❯",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
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
<<<<<<< Updated upstream
                                    Text(
                                        '${chatData[index].currPeople}/${chatData[index].maxPeople}'),
=======
                                    if(chatData[index].currPeople != chatData[index].maxPeople)
                                        Text('${chatData[index].currPeople}/${chatData[index].maxPeople}')
                                    else
                                      Text(
                                        '${chatData[index].currPeople}/${chatData[index].maxPeople}',
                                        style: const TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                            decorationThickness: 3
                                        ),
                                      ),
>>>>>>> Stashed changes
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

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    '행복한 마라탕',
    '명성',
    '신전 떡볶이',
    'bbq',
    '동궁찜닭',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.blue,
          ),
          onPressed: () {
<<<<<<< Updated upstream
            if (query == "") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MainScreen())); //close searchbar
=======
            if (query=="") {
              Navigator.of(context).pop();//close searchbar
>>>>>>> Stashed changes
            } else {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
              query = "";
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(
        // close searchbar
        Icons.arrow_back,
        color: Colors.blue,
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      });

  int itemCnt() {
    int count = 0;
    for (int i = 0; i < chatData.length; i++) {
      if (chatData[i].name.contains(query)) {
        if ((int.parse(chatData[i].time.substring(0, 2)) >
            int.parse(currHour)) ||
            ((int.parse(chatData[i].time.substring(0, 2)) ==
                int.parse(currHour)) &&
                (int.parse(chatData[i].time.substring(3, 5)) >
                    int.parse(currMinute)))) {
          count++;
        }
      }
    }
    return count;
  }

  var flag = List.empty(growable: true);
  int j=0;
  @override
  Widget buildResults(BuildContext context) => Center(
        child: ListView.builder(
          itemCount: itemCnt(),
          itemBuilder: (context, index) {
            for(int i=0; i<chatData.length; i++) {
              if (chatData[i].name.contains(query)) {
                if ((int.parse(chatData[i].time.substring(0, 2)) >
                    int.parse(currHour)) ||
                    ((int.parse(chatData[i].time.substring(0, 2)) ==
                        int.parse(currHour)) &&
                        (int.parse(chatData[i].time.substring(3, 5)) >
                            int.parse(currMinute)))) {
                  flag.add(i);
                }
              }
            }
            index = flag[j];
            j++;
            return GestureDetector(
              onTap: () {
<<<<<<< Updated upstream
                debugPrint(nameList[index]);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatRoom(
                          chat: chatData[index],
                        )));
=======
                if(chatData[index].currPeople != chatData[index].maxPeople) {
                  debugPrint(chatData[index].name);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatRoom(chat: chatData[index],)));
                }else{
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext ctx){
                        return AlertDialog(
                          title: Text("정원초과"),
                          content: Text("인원이 마감되었습니다."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("확인"),
                            ),
                          ],
                        );
                      }
                  );
                }
>>>>>>> Stashed changes
              },
              child: Card(
                color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.grey : Colors.white,
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_sharp,
                                    color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.black : Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    chatData[index].user,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: (chatData[index].currPeople == chatData[index].maxPeople) ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(chatData[index].time),
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
                                chatData[index].name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              if(chatData[index].currPeople != chatData[index].maxPeople)
                                const Text(
                                  " ❯",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              else
                                const Text(
                                  " ❯",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
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
<<<<<<< Updated upstream
                                      Text(
                                          '${chatData[index].currPeople}/${chatData[index].maxPeople}'),
=======
                                      if(chatData[index].currPeople != chatData[index].maxPeople)
                                        Text('${chatData[index].currPeople}/${chatData[index].maxPeople}')
                                      else
                                        Text(
                                          '${chatData[index].currPeople}/${chatData[index].maxPeople}',
                                          style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              decorationThickness: 3
                                          ),
                                        ),
>>>>>>> Stashed changes
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

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
