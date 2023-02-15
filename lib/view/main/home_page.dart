import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:han_bab/controller/home_controller.dart';
import 'package:han_bab/controller/search_controller.dart';
import 'package:han_bab/view/chat/add_chat_room.dart';
import 'package:intl/intl.dart';
import '../../component/customToolbarShape.dart';
import '../../component/database_service.dart';
import '../../model/search.dart';
import '../chat/chatRoom_screen.dart';
import 'package:get/get.dart';

DateTime now = DateTime.now();
String currHour = DateFormat("HH").format(now);
String currMinute = DateFormat("mm").format(now);

String getName(String res) {
  return res.substring(res.indexOf("_") + 1);
}

class HomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final controller = Get.put(SearchController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
                color: Colors.transparent,
                child: Stack(fit: StackFit.loose, children: <Widget>[
                  Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const CustomPaint(
                        painter:
                            CustomToolbarShape(lineColor: Colors.blueAccent),
                      )),
                  const Align(
                    alignment: Alignment(0.0, -0.5),
                    child: Text(
                      "한동 밥먹자",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Align(
                      alignment: const Alignment(0.0, 1.25),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 14.5,
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
                            child: Autocomplete<RestaurantName>(
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text != "") {
                                  return controller.countryNames
                                      .where((RestaurantName country) => country
                                          .name
                                          .toLowerCase()
                                          .contains(textEditingValue.text
                                              .toLowerCase()))
                                      .toList();
                                } else {
                                  return controller.countryNames
                                      .where((RestaurantName country) => country
                                          .name
                                          .toLowerCase()
                                          .contains("?"))
                                      .toList();
                                }
                              },
                              displayStringForOption:
                                  (RestaurantName country) => country.name,
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController
                                      fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextField(
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
                                              BorderRadius.circular(25))),
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                );
                              },
                              onSelected: (RestaurantName selection) {
                                print('Selected: ${selection.name}');
                                if (selection.name == "") {
                                  homeController.restaurants.bindStream(
                                      FirestoreDB().getAllRestaurants());
                                } else {
                                  homeController.restaurants.bindStream(
                                      FirestoreDB().getSearchRestaurants(
                                          selection.name.toUpperCase()));
                                }
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<RestaurantName>
                                      onSelected,
                                  Iterable<RestaurantName> country) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.orange,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(1.0),
                                          itemCount: country.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final RestaurantName option =
                                                country.elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                onSelected(option);
                                              },
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      option.name,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ))),
                ])),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: FutureBuilder(
                  future: Future.delayed(
                    const Duration(milliseconds: 2500),
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
                          homeController.restaurants
                              .bindStream(FirestoreDB().getAllRestaurants());
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => homeController.restaurants.isEmpty
                                  ? Expanded(
                                      child:
                                          ListView(shrinkWrap: true, children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 150,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.to(() => AddChatRoom());
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_circle,
                                                    size: 60,
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Text(
                                              "현재 생성된 채팅방이 없습니다.",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            const Text("버튼을 클릭해서 채팅방을 추가하세요!",
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ]),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              homeController.restaurants.length,
                                          itemBuilder: (context, index) {
                                            String userName = "";
                                            return GestureDetector(
                                              onTap: () async {
                                                if (homeController
                                                        .restaurants[index]
                                                        .currPeople !=
                                                    homeController
                                                        .restaurants[index]
                                                        .maxPeople) {
                                                  var result =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('user')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .get();
                                                  userName =
                                                      result['userNickName'];
                                                  DatabaseService(
                                                          uid: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                      .groupJoin(
                                                          homeController
                                                              .restaurants[
                                                                  index]
                                                              .groupId,
                                                          userName,
                                                          homeController
                                                              .restaurants[
                                                                  index]
                                                              .groupName)
                                                      .whenComplete(
                                                          () => {
                                                                Get.to(
                                                                    () =>
                                                                        ChatRoom(),
                                                                    arguments:
                                                                        homeController
                                                                            .restaurants[index])
                                                              });
                                                } else {
                                                  if (!await DatabaseService(
                                                          uid: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                      .isUserJoined(
                                                          homeController
                                                              .restaurants[
                                                                  index]
                                                              .groupName,
                                                          homeController
                                                              .restaurants[
                                                                  index]
                                                              .groupId,
                                                          userName)) {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder:
                                                            (BuildContext ctx) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "정원초과"),
                                                            content: const Text(
                                                                "인원이 마감되었습니다."),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "확인"),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  } else {
                                                    Get.to(() => ChatRoom(),
                                                        arguments: homeController
                                                                .restaurants[
                                                            index]);
                                                  }
                                                }
                                              },
                                              child:
                                                  (homeController
                                                              .restaurants[
                                                                  index]
                                                              .currPeople ==
                                                          homeController
                                                              .restaurants[
                                                                  index]
                                                              .maxPeople)
                                                      ? ImageFiltered(
                                                          imageFilter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 2,
                                                                  sigmaY: 2),
                                                          child: Card(
                                                            color: (homeController
                                                                        .restaurants[
                                                                            index]
                                                                        .currPeople ==
                                                                    homeController
                                                                        .restaurants[
                                                                            index]
                                                                        .maxPeople)
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 100,
                                                                  height: 100,
                                                                  child:
                                                                      ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20.0),
                                                                          child:
                                                                              Image.network(
                                                                            homeController.restaurants[index].imgUrl,
                                                                            // loadingBuilder: (BuildContext? context, Widget? child,
                                                                            //     ImageChunkEvent? loadingProgress) {
                                                                            //   if (loadingProgress == null) return child!;
                                                                            //   return Center(
                                                                            //     child: CircularProgressIndicator(
                                                                            //       value: loadingProgress.expectedTotalBytes != null
                                                                            //           ? loadingProgress.cumulativeBytesLoaded /
                                                                            //           loadingProgress.expectedTotalBytes!
                                                                            //           : null,
                                                                            //     ),
                                                                            //   );
                                                                            // },
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorBuilder: (BuildContext? context,
                                                                                Object? exception,
                                                                                StackTrace? stackTrace) {
                                                                              return Container(
                                                                                height: 120,
                                                                                width: 120,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(width: 3),
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                                    child: Image.asset(
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
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.account_circle_sharp,
                                                                                color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople) ? Colors.black : Colors.grey,
                                                                                size: 16,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 8,
                                                                              ),
                                                                              Text(
                                                                                getName(homeController.restaurants[index].admin),
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople) ? Colors.black : Colors.grey,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(homeController.restaurants[index].orderTime),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            homeController.restaurants[index].groupName,
                                                                            style: const TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black),
                                                                          ),
                                                                          if (homeController.restaurants[index].currPeople !=
                                                                              homeController.restaurants[index].maxPeople)
                                                                            const Icon(
                                                                              Icons.keyboard_double_arrow_right,
                                                                              color: Colors.redAccent,
                                                                            )
                                                                          else
                                                                            const Icon(
                                                                              Icons.keyboard_double_arrow_right,
                                                                              color: Colors.black,
                                                                            )
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            homeController.restaurants[index].pickup,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople) ? Colors.black : Colors.grey,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            child:
                                                                                FittedBox(
                                                                              child: Row(
                                                                                children: [
                                                                                  const Icon(CupertinoIcons.person),
                                                                                  if (homeController.restaurants[index].currPeople != homeController.restaurants[index].maxPeople)
                                                                                    Text('${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}')
                                                                                  else
                                                                                    Text(
                                                                                      '${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}',
                                                                                      style: const TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.red, decorationThickness: 3),
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
                                                        )
                                                      : Card(
                                                          color: (homeController
                                                                      .restaurants[
                                                                          index]
                                                                      .currPeople ==
                                                                  homeController
                                                                      .restaurants[
                                                                          index]
                                                                      .maxPeople)
                                                              ? Colors.grey
                                                              : Colors.white,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 100,
                                                                height: 100,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20.0),
                                                                        child: Image
                                                                            .network(
                                                                          homeController
                                                                              .restaurants[index]
                                                                              .imgUrl,
                                                                          // loadingBuilder: (BuildContext? context, Widget? child,
                                                                          //     ImageChunkEvent? loadingProgress) {
                                                                          //   if (loadingProgress == null) return child!;
                                                                          //   return Center(
                                                                          //     child: CircularProgressIndicator(
                                                                          //       value: loadingProgress.expectedTotalBytes != null
                                                                          //           ? loadingProgress.cumulativeBytesLoaded /
                                                                          //           loadingProgress.expectedTotalBytes!
                                                                          //           : null,
                                                                          //     ),
                                                                          //   );
                                                                          // },
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (BuildContext? context,
                                                                              Object? exception,
                                                                              StackTrace? stackTrace) {
                                                                            return Container(
                                                                              height: 120,
                                                                              width: 120,
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(width: 3),
                                                                                borderRadius: BorderRadius.circular(20),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  child: Image.asset(
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
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.account_circle_sharp,
                                                                              color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople) ? Colors.black : Colors.grey,
                                                                              size: 16,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Text(
                                                                              getName(homeController.restaurants[index].admin),
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople) ? Colors.black : Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(homeController.restaurants[index].orderTime),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          homeController
                                                                              .restaurants[index]
                                                                              .groupName,
                                                                          style: const TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),
                                                                        if (homeController.restaurants[index].currPeople !=
                                                                            homeController.restaurants[index].maxPeople)
                                                                          const Icon(
                                                                            Icons.keyboard_double_arrow_right,
                                                                            color:
                                                                                Colors.redAccent,
                                                                          )
                                                                        else
                                                                          const Icon(
                                                                            Icons.keyboard_double_arrow_right,
                                                                            color:
                                                                                Colors.black,
                                                                          )
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
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color: (homeController.restaurants[index].currPeople == homeController.restaurants[index].maxPeople)
                                                                                ? Colors.black
                                                                                : Colors.grey,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          child:
                                                                              FittedBox(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Icon(CupertinoIcons.person),
                                                                                if (homeController.restaurants[index].currPeople != homeController.restaurants[index].maxPeople)
                                                                                  Text('${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}')
                                                                                else
                                                                                  Text(
                                                                                    '${homeController.restaurants[index].currPeople}/${homeController.restaurants[index].maxPeople}',
                                                                                    style: const TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.red, decorationThickness: 3),
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
                                          }),
                                    ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ),
          )),
    );
  }
}
