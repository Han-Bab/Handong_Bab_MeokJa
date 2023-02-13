import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:han_bab/controller/home_controller.dart';
import 'package:intl/intl.dart';
import '../../component/customToolbarShape.dart';
import '../../component/database_service.dart';
import '../chat/chatRoom_screen.dart';
import 'main_screen.dart';
import 'package:get/get.dart';

DateTime now = DateTime.now();
String currHour = DateFormat("HH").format(now);
String currMinute = DateFormat("mm").format(now);

String getName(String res) {
  return res.substring(res.indexOf("_") + 1);
}

class HomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);
  //
  // Future<void> refresh() {
  //   return Future.delayed(const Duration(seconds: 1)); // 1초 후 리턴
  // }

  Future<String> _fetch1() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Call Data';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
              color: Colors.transparent,
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Container(
                    color: Colors.transparent,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: const CustomPaint(
                      painter: CustomToolbarShape(lineColor: Colors.blueAccent),
                    )),
                const Align(alignment: Alignment(0.0, -0.4),
                  child: Text("한동 밥먹자", style: TextStyle(color: Colors.white, fontSize: 30),),
                ),
                Align(
                    alignment: const Alignment(0.0, 1.25),
                    child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 14.5,
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20.0,
                                  // shadow
                                  spreadRadius: .5,
                                  // set effect of extending the shadow
                                  offset: Offset(
                                    0.0,
                                    5.0,
                                  ),
                                )
                              ],
                            ),
                            child: TextField(
                                onSubmitted: (submittedText) {
                                  if (submittedText == "") {
                                    homeController.restaurants.bindStream(
                                        FirestoreDB().getAllRestaurants());
                                  } else {
                                    homeController.restaurants.bindStream(
                                        FirestoreDB().getSearchRestaurants(
                                            submittedText.toUpperCase()));
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.black38,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius:
                                        BorderRadius.circular(25))))))),
              ])),
        ),
        // actions: [
        //   Column(
        //     children: [
        //       Text("채팅방"),
        //       Flexible(
        //         child: Card(
        //           child: OutlinedButton.icon(
        //             onPressed: () {
        //
        //             },
        //             icon: const Icon(
        //               Icons.search,
        //               color: Colors.blue,
        //             ),
        //             label: const Text("Search"),
        //             style: OutlinedButton.styleFrom(
        //               alignment: Alignment.centerLeft,
        //               foregroundColor: Colors.blue,
        //               textStyle: const TextStyle(fontSize: 20),
        //               minimumSize: const Size(420, 0),
        //               side: const BorderSide(
        //                 color: Colors.transparent,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        //   const SizedBox(
        //     width: 5,
        //   ),
        // ],
        //appbar 경계선

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 500),
                  ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        homeController.restaurants.bindStream(FirestoreDB().getAllRestaurants());
                        ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          '새로고침 되었습니다.')) // refresh 완료시 snackbar 생성
                              );
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Obx(
                                () =>
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: homeController.restaurants.length,
                                    itemBuilder: (context, index) {
                                      String userName = "";
                                      if (homeController
                                          .restaurants[index].members
                                          .isNotEmpty) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (homeController
                                                .restaurants[index].currPeople !=
                                                homeController
                                                    .restaurants[index]
                                                    .maxPeople) {
                                              var result = await FirebaseFirestore
                                                  .instance
                                                  .collection('user')
                                                  .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                                  .get();
                                              userName = result['userName'];
                                              DatabaseService(
                                                  uid: FirebaseAuth
                                                      .instance.currentUser!.uid)
                                                  .groupJoin(
                                                  homeController
                                                      .restaurants[index].groupId,
                                                  userName,
                                                  homeController
                                                      .restaurants[index]
                                                      .groupName)
                                                  .whenComplete(() =>
                                              {
                                                Get.to(() => ChatRoom(),
                                                    arguments: homeController
                                                        .restaurants[index])
                                              });
                                            } else {
                                              if (!await DatabaseService(
                                                  uid: FirebaseAuth
                                                      .instance.currentUser!.uid)
                                                  .isUserJoined(
                                                  homeController
                                                      .restaurants[index]
                                                      .groupName,
                                                  homeController
                                                      .restaurants[index].groupId,
                                                  userName)) {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext ctx) {
                                                      return AlertDialog(
                                                        title: const Text("정원초과"),
                                                        content: const Text(
                                                            "인원이 마감되었습니다."),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                                "확인"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                Get.to(() => ChatRoom(),
                                                    arguments:
                                                    homeController
                                                        .restaurants[index]);
                                              }
                                            }
                                          },
                                          child: (homeController
                                              .restaurants[index].currPeople ==
                                              homeController
                                                  .restaurants[index].maxPeople) ? ImageFiltered(
                                            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                            child: Card(
                                              color: (homeController
                                                  .restaurants[index].currPeople ==
                                                  homeController
                                                      .restaurants[index].maxPeople)
                                                  ? Colors.grey
                                                  : Colors.white,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(20.0),
                                                        child: Image.asset(
                                                          homeController
                                                              .restaurants[index]
                                                              .imgUrl,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                              BuildContext? context,
                                                              Object? exception,
                                                              StackTrace? stackTrace) {
                                                            return Container(
                                                              height: 120,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 3),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(20),
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/hanbab_icon.png',
                                                                    scale: 5,
                                                                  )),
                                                            );
                                                          },
                                                        )),
                                                  ), //image
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .account_circle_sharp,
                                                                  color: (homeController
                                                                      .restaurants[
                                                                  index]
                                                                      .currPeople ==
                                                                      homeController
                                                                          .restaurants[
                                                                      index]
                                                                          .maxPeople)
                                                                      ? Colors.black
                                                                      : Colors.grey,
                                                                  size: 16,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  getName(
                                                                      homeController
                                                                          .restaurants[index]
                                                                          .admin),
                                                                  style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: (homeController
                                                                        .restaurants[
                                                                    index]
                                                                        .currPeople ==
                                                                        homeController
                                                                            .restaurants[
                                                                        index]
                                                                            .maxPeople)
                                                                        ? Colors
                                                                        .black
                                                                        : Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(homeController
                                                                    .restaurants[index]
                                                                    .orderTime),
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
                                                              homeController
                                                                  .restaurants[index]
                                                                  .groupName,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            if (homeController
                                                                .restaurants[index]
                                                                .currPeople !=
                                                                homeController
                                                                    .restaurants[index]
                                                                    .maxPeople)
                                                              const Icon(Icons.keyboard_double_arrow_right, color: Colors.redAccent,)
                                                            else
                                                              const Icon(Icons.keyboard_double_arrow_right, color: Colors.black,)
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              homeController
                                                                  .restaurants[index]
                                                                  .pickup,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: (homeController
                                                                    .restaurants[
                                                                index]
                                                                    .currPeople ==
                                                                    homeController
                                                                        .restaurants[
                                                                    index]
                                                                        .maxPeople)
                                                                    ? Colors.black
                                                                    : Colors.grey,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                        CupertinoIcons
                                                                            .person),
                                                                    if (homeController
                                                                        .restaurants[
                                                                    index]
                                                                        .currPeople !=
                                                                        homeController
                                                                            .restaurants[
                                                                        index]
                                                                            .maxPeople)
                                                                      Text(
                                                                          '${homeController
                                                                              .restaurants[index]
                                                                              .currPeople}/${homeController
                                                                              .restaurants[index]
                                                                              .maxPeople}')
                                                                    else
                                                                      Text(
                                                                        '${homeController
                                                                            .restaurants[index]
                                                                            .currPeople}/${homeController
                                                                            .restaurants[index]
                                                                            .maxPeople}',
                                                                        style: const TextStyle(
                                                                            decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                            decorationColor:
                                                                            Colors
                                                                                .red,
                                                                            decorationThickness:
                                                                            3),
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
                                          ) : Card(
                                            color: (homeController
                                                .restaurants[index].currPeople ==
                                                homeController
                                                    .restaurants[index].maxPeople)
                                                ? Colors.grey
                                                : Colors.white,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(20.0),
                                                      child: Image.asset(
                                                        homeController
                                                            .restaurants[index]
                                                            .imgUrl,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                            BuildContext? context,
                                                            Object? exception,
                                                            StackTrace? stackTrace) {
                                                          return Container(
                                                            height: 120,
                                                            width: 120,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 3),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20.0),
                                                                child: Image
                                                                    .asset(
                                                                  'assets/hanbab_icon.png',
                                                                  scale: 5,
                                                                )),
                                                          );
                                                        },
                                                      )),
                                                ), //image
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .account_circle_sharp,
                                                                color: (homeController
                                                                    .restaurants[
                                                                index]
                                                                    .currPeople ==
                                                                    homeController
                                                                        .restaurants[
                                                                    index]
                                                                        .maxPeople)
                                                                    ? Colors.black
                                                                    : Colors.grey,
                                                                size: 16,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                getName(
                                                                    homeController
                                                                        .restaurants[index]
                                                                        .admin),
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: (homeController
                                                                      .restaurants[
                                                                  index]
                                                                      .currPeople ==
                                                                      homeController
                                                                          .restaurants[
                                                                      index]
                                                                          .maxPeople)
                                                                      ? Colors
                                                                      .black
                                                                      : Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(homeController
                                                                  .restaurants[index]
                                                                  .orderTime),
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
                                                            homeController
                                                                .restaurants[index]
                                                                .groupName,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          if (homeController
                                                              .restaurants[index]
                                                              .currPeople !=
                                                              homeController
                                                                  .restaurants[index]
                                                                  .maxPeople)
                                                            const Icon(Icons.keyboard_double_arrow_right, color: Colors.redAccent,)
                                                          else
                                                            const Icon(Icons.keyboard_double_arrow_right, color: Colors.black,)
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            homeController
                                                                .restaurants[index]
                                                                .pickup,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: (homeController
                                                                  .restaurants[
                                                              index]
                                                                  .currPeople ==
                                                                  homeController
                                                                      .restaurants[
                                                                  index]
                                                                      .maxPeople)
                                                                  ? Colors.black
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            child: FittedBox(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                      CupertinoIcons
                                                                          .person),
                                                                  if (homeController
                                                                      .restaurants[
                                                                  index]
                                                                      .currPeople !=
                                                                      homeController
                                                                          .restaurants[
                                                                      index]
                                                                          .maxPeople)
                                                                    Text(
                                                                        '${homeController
                                                                            .restaurants[index]
                                                                            .currPeople}/${homeController
                                                                            .restaurants[index]
                                                                            .maxPeople}')
                                                                  else
                                                                    Text(
                                                                      '${homeController
                                                                          .restaurants[index]
                                                                          .currPeople}/${homeController
                                                                          .restaurants[index]
                                                                          .maxPeople}',
                                                                      style: const TextStyle(
                                                                          decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                          decorationColor:
                                                                          Colors
                                                                              .red,
                                                                          decorationThickness:
                                                                          3),
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
                                      } else {
                                        return const SizedBox(
                                          height: 0,
                                        );
                                      }
                                    },
                                  ),
                                ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
//
// // 검색
// class MySearchDelegate extends SearchDelegate {
//   final homeController = Get.put(HomeController());
//   List<String> searchResults = [
//     '행복한 마라탕',
//     '명성',
//     '신전 떡볶이',
//     'bbq',
//     '동궁찜닭',
//   ];
//
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//           icon: const Icon(
//             Icons.clear,
//             color: Colors.blue,
//           ),
//           onPressed: () {
//             if (query == "") {
//               Get.back(); //close searchbar
//             } else {
//               showSearch(
//                 context: context,
//                 delegate: MySearchDelegate(),
//               );
//               query = "";
//             }
//           },
//         ),
//       ];
//
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//       icon: const Icon(
//         // close searchbar
//         Icons.arrow_back,
//         color: Colors.blue,
//       ),
//       onPressed: () {
//         Get.offAll(() => MainScreen());
//       });
//
//   @override
//   Widget buildResults(BuildContext context) => Center(
//         child: Obx(
//           () => ListView.builder(
//             itemCount: homeController.restaurants.length,
//             itemBuilder: (context, index) {
//               if (homeController.restaurants[index].groupName.contains(query) &&
//                   (homeController.restaurants[index].members.isNotEmpty)) {
//                 String userName = "";
//                 return GestureDetector(
//                   onTap: () async {
//                     if (homeController.restaurants[index].currPeople !=
//                         homeController.restaurants[index].maxPeople) {
//                       var result = await FirebaseFirestore.instance
//                           .collection('user')
//                           .doc(FirebaseAuth.instance.currentUser!.uid)
//                           .get();
//                       userName = result['userName'];
//                       DatabaseService(
//                               uid: FirebaseAuth.instance.currentUser!.uid)
//                           .groupJoin(
//                               homeController.restaurants[index].groupId,
//                               userName,
//                               homeController.restaurants[index].groupName);
//                       Get.to(() => ChatRoom(),
//                           arguments: homeController.restaurants[index]);
//                     } else {
//                       if (!await DatabaseService(
//                               uid: FirebaseAuth.instance.currentUser!.uid)
//                           .isUserJoined(
//                               homeController.restaurants[index].groupName,
//                               homeController.restaurants[index].groupId,
//                               userName)) {
//                         showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext ctx) {
//                               return AlertDialog(
//                                 title: const Text("정원초과"),
//                                 content: const Text("인원이 마감되었습니다."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                     child: const Text("확인"),
//                                   ),
//                                 ],
//                               );
//                             });
//                       } else {
//                         Get.to(() => ChatRoom(),
//                             arguments: homeController.restaurants[index]);
//                       }
//                     }
//                   },
//                   child: Card(
//                     color: (homeController.restaurants[index].currPeople ==
//                             homeController.restaurants[index].maxPeople)
//                         ? Colors.grey
//                         : Colors.white,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 100,
//                           height: 100,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20.0),
//                               child: Image.asset(
//                                 homeController.restaurants[index].imgUrl,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (BuildContext? context,
//                                     Object? exception, StackTrace? stackTrace) {
//                                   return Container(
//                                     height: 120,
//                                     width: 120,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(width: 3),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                         child: Image.asset(
//                                           'assets/hanbab_icon.png',
//                                           scale: 5,
//                                         )),
//                                   );
//                                 },
//                               )),
//                         ), //image
//                         const SizedBox(
//                           width: 16,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.account_circle_sharp,
//                                         color: (homeController
//                                                     .restaurants[index]
//                                                     .currPeople ==
//                                                 homeController
//                                                     .restaurants[index]
//                                                     .maxPeople)
//                                             ? Colors.black
//                                             : Colors.grey,
//                                         size: 16,
//                                       ),
//                                       const SizedBox(
//                                         width: 8,
//                                       ),
//                                       Text(
//                                         getName(homeController
//                                             .restaurants[index].admin),
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: (homeController
//                                                       .restaurants[index]
//                                                       .currPeople ==
//                                                   homeController
//                                                       .restaurants[index]
//                                                       .maxPeople)
//                                               ? Colors.black
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(homeController
//                                           .restaurants[index].orderTime),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     homeController.restaurants[index].groupName,
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                   if (homeController
//                                           .restaurants[index].currPeople !=
//                                       homeController
//                                           .restaurants[index].maxPeople)
//                                     const Text(
//                                       " ❯",
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red),
//                                     )
//                                   else
//                                     const Text(
//                                       " ❯",
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     homeController.restaurants[index].pickup,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: (homeController.restaurants[index]
//                                                   .currPeople ==
//                                               homeController
//                                                   .restaurants[index].maxPeople)
//                                           ? Colors.black
//                                           : Colors.grey,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     child: FittedBox(
//                                       child: Row(
//                                         children: [
//                                           const Icon(CupertinoIcons.person),
//                                           if (homeController.restaurants[index]
//                                                   .currPeople !=
//                                               homeController
//                                                   .restaurants[index].maxPeople)
//                                             Text(
//                                                 '${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}')
//                                           else
//                                             Text(
//                                               '${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}',
//                                               style: const TextStyle(
//                                                   decoration: TextDecoration
//                                                       .lineThrough,
//                                                   decorationColor: Colors.red,
//                                                   decorationThickness: 3),
//                                             ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else {
//                 return const SizedBox(
//                   height: 1,
//                 );
//               }
//             },
//           ),
//         ),
//       );
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions = searchResults.where((searchResult) {
//       final result = searchResult.toLowerCase();
//       final input = query.toLowerCase();
//       return result.contains(input);
//     }).toList();
//
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final suggestion = suggestions[index];
//         return ListTile(
//           title: Text(suggestion),
//           onTap: () {
//             query = suggestion;
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
