import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final userList = ['aa', 'bb', 'cc', 'dd', 'ee', 'ff', 'gg', 'hh', 'ii', 'jj'];
final nameList = ['류앤돈까스', '동궁찜닭', '꼬꼬뽀끼', 'bbq', '행복한 마라탕', '삼촌네?', '신전 떡볶이', '명성', '땅땅치킨', '행복한 마라탕'];
final time = ['17:00', '14:00', '13:20', '11:30', '15:30', '18:00', '21:00', '23:00', '13:00', '12:00'];
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

int person =0;
int max_people=4;

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '검색',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                  Icons.search,
                  color: Colors.blue,
              ),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                );
              },
          )
        ],
        backgroundColor: Colors.white70,
        elevation: 10, //appbar 경계선
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
                  SizedBox(width: 16,),
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
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Text(time[index]),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          nameList[index],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                                    Text('$person/$max_people'),
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
          if (query.isEmpty) {
            close(context, null); //close searchbar
          } else {
            query = '';
          }
        },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.blue,
      ),
      onPressed: () => close(context, null), // close searchbar
  );


  int itemCnt() {
    int count=0;
    for(int i=0;i<nameList.length;i++){
      if(nameList[i].contains(query)) {
        count++;
      }
    }
    return count;
  }
  
  int flag=-1;
  @override
  Widget buildResults(BuildContext context) => Center(
    child: ListView.builder(
      itemCount: itemCnt(),
      itemBuilder: (context, index) {
        for(int i=0;i<nameList.length;i++){
          if(nameList[i].contains(query)) {
            if(flag!=i){
              index = i;
              flag = i;
              break;
            }
          }
        }
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userList[index],
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            nameList[index],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // SizedBox(
                          //   width: width,
                          //   child: Text(
                          //     description[index],
                          //     style: TextStyle(
                          //         fontSize: 15, color: Colors.grey[500]),
                          //   ),
                          // )
                        ],
                      ),
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
    List<String> suggestions = searchResults.where((searchResult){
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