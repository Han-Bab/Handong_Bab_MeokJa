import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:han_bab/controller/home_controller.dart';
import 'package:intl/intl.dart';
import '../chat/chatRoom_screen.dart';
import 'main_screen.dart';
import 'package:get/get.dart';

DateTime now = DateTime.now();
String currHour = DateFormat("HH").format(now);
String currMinute = DateFormat("mm").format(now);

var flag1 = List.empty(growable: true);
int j=0;

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());
  late List<String> items;

  @override
  void initState() {
    super.initState();
    //items = dummies.sublist(0, 20);
  }

  Future<void> refresh() {
    return Future.delayed(const Duration(seconds: 1));  // 1초 후 리턴
  }

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
                label: const Text("Search"),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 20),
                  minimumSize: const Size(420, 0),
                  side: const BorderSide(
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
      body: RefreshIndicator(
        onRefresh: () => refresh().then((_) => {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('새로고침 되었습니다.')) // refresh 완료시 snackbar 생성
          )
        }),
        child: Obx(() => ListView.builder(
          itemCount: homeController.restaurant.length,
          itemBuilder: (context, index) {
            if((int.parse(homeController.restaurant[index].time.substring(0,2))>int.parse(currHour)-3)||
                ((int.parse(homeController.restaurant[index].time.substring(0,2))==int.parse(currHour)-3)&&(int.parse(homeController.restaurant[index].time.substring(3,5))>int.parse(currMinute)))) {

              return GestureDetector(
              onTap: () {
                if(homeController.restaurant[index].currPeople != homeController.restaurant[index].maxPeople) {
                  debugPrint(homeController.restaurant[index].restaurantName);
                  Get.to(const ChatRoom());
                }else{
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext ctx){
                        return AlertDialog(
                          title: const Text("정원초과"),
                          content: const Text("인원이 마감되었습니다."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("확인"),
                            ),
                          ],
                        );
                      }
                  );
                }
              },
              child: Card(
                color: (homeController.restaurant[index].currPeople == homeController.restaurant[index].maxPeople) ? Colors.grey : Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          homeController.restaurant[index].imgUrl,
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
                                    color: (homeController.restaurant[index].currPeople == homeController.restaurant[index].maxPeople) ? Colors.black : Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    homeController.restaurant[index].userName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: (homeController.restaurant[index].currPeople == homeController.restaurant[index].maxPeople) ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(homeController.restaurant[index].time),
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
                                homeController.restaurant[index].restaurantName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              if(homeController.restaurant[index].currPeople != homeController.restaurant[index].maxPeople)
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
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                homeController.restaurant[index].position,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (homeController.restaurant[index].currPeople == homeController.restaurant[index].maxPeople) ? Colors.black : Colors.grey,
                                ),
                              ),
                              SizedBox(
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      const Icon(CupertinoIcons.person),
                                      if(homeController.restaurant[index].currPeople != homeController.restaurant[index].maxPeople)
                                        Text('${homeController.restaurant[index].currPeople}/${homeController.restaurant[index].maxPeople}')
                                      else
                                        Text(
                                          '${homeController.restaurant[index].currPeople}/${homeController.restaurant[index].maxPeople}',
                                          style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              decorationThickness: 3
                                          ),
                                        ),
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
            }else{
              return const SizedBox(height: 1,);
            }
          },
        ),
        ),
      ),
    );
  }
}


// 검색
class MySearchDelegate extends SearchDelegate {

  final homeController = Get.put(HomeController());
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
            if (query=="") {
              Get.back();//close searchbar
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
        Get.to(const MainScreen());
      });

  var flag = List.empty(growable: true);
  int j=0;
  @override
  Widget buildResults(BuildContext context) => Center(
        child: Obx(()=>ListView.builder(
            itemCount: homeController.restaurant.length,
            itemBuilder: (context, index) {
              print(homeController.restaurant[index].restaurantName);
              print(query);
              if (homeController.restaurant[index].restaurantName.contains(query)){
                 if((int.parse(homeController.restaurant[index].time.substring(0,2))>int.parse(currHour)-3)||
                   ((int.parse(homeController.restaurant[index].time.substring(0,2))==int.parse(currHour)-3)&&(int.parse(homeController.restaurant[index].time.substring(3,5))>int.parse(currMinute)))) {
                   return GestureDetector(
                     onTap: () {
                       if (homeController.restaurant[index].currPeople !=
                           homeController.restaurant[index].maxPeople) {
                         debugPrint(
                             homeController.restaurant[index].restaurantName);
                         Get.to(const ChatRoom());
                       } else {
                         showDialog(
                             context: context,
                             barrierDismissible: false,
                             builder: (BuildContext ctx) {
                               return AlertDialog(
                                 title: const Text("정원초과"),
                                 content: const Text("인원이 마감되었습니다."),
                                 actions: [
                                   TextButton(
                                     onPressed: () {
                                       Get.back();
                                     },
                                     child: const Text("확인"),
                                   ),
                                 ],
                               );
                             }
                         );
                       }
                     },
                     child: Card(
                       color: (homeController.restaurant[index].currPeople ==
                           homeController.restaurant[index].maxPeople) ? Colors
                           .grey : Colors.white,
                       child: Row(
                         children: [
                           SizedBox(
                             width: 100,
                             height: 100,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(20.0),
                               child: Image.asset(
                                 homeController.restaurant[index].imgUrl,
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
                                   mainAxisAlignment: MainAxisAlignment
                                       .spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                         Icon(
                                           Icons.account_circle_sharp,
                                           color: (homeController
                                               .restaurant[index].currPeople ==
                                               homeController.restaurant[index]
                                                   .maxPeople)
                                               ? Colors.black
                                               : Colors.grey,
                                           size: 16,
                                         ),
                                         const SizedBox(
                                           width: 8,
                                         ),
                                         Text(
                                           homeController.restaurant[index]
                                               .userName,
                                           style: TextStyle(
                                             fontSize: 15,
                                             color: (homeController
                                                 .restaurant[index]
                                                 .currPeople ==
                                                 homeController
                                                     .restaurant[index]
                                                     .maxPeople)
                                                 ? Colors.black
                                                 : Colors.grey,
                                           ),
                                         ),
                                       ],
                                     ),
                                     Row(
                                       children: [
                                         Text(homeController.restaurant[index]
                                             .time),
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
                                       homeController.restaurant[index]
                                           .restaurantName,
                                       style: const TextStyle(
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black),
                                     ),
                                     if(homeController.restaurant[index]
                                         .currPeople !=
                                         homeController.restaurant[index]
                                             .maxPeople)
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
                                   height: 8,
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment
                                       .spaceBetween,
                                   children: [
                                     Text(
                                       homeController.restaurant[index]
                                           .position,
                                       style: TextStyle(
                                         fontSize: 15,
                                         color: (homeController
                                             .restaurant[index]
                                             .currPeople ==
                                             homeController.restaurant[index]
                                                 .maxPeople)
                                             ? Colors.black
                                             : Colors.grey,
                                       ),
                                     ),
                                     SizedBox(
                                       child: FittedBox(
                                         child: Row(
                                           children: [
                                             const Icon(CupertinoIcons.person),
                                             if(homeController.restaurant[index]
                                                 .currPeople !=
                                                 homeController
                                                     .restaurant[index]
                                                     .maxPeople)
                                               Text('${homeController
                                                   .restaurant[index]
                                                   .currPeople}/${homeController
                                                   .restaurant[index]
                                                   .maxPeople}')
                                             else
                                               Text(
                                                 '${homeController
                                                     .restaurant[index]
                                                     .currPeople}/${homeController
                                                     .restaurant[index]
                                                     .maxPeople}',
                                                 style: const TextStyle(
                                                     decoration: TextDecoration
                                                         .lineThrough,
                                                     decorationColor: Colors
                                                         .red,
                                                     decorationThickness: 3
                                                 ),
                                               ),
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
                 }else{
                   return const SizedBox(height: 1,);
                 }
              }else{
                return const SizedBox(height: 1,);
              }
            },
          ),
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
