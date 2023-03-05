import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/mychat_controller.dart';
import '../chat/chatRoom_screen.dart';
import 'home_page.dart';

class GroupListViewDemo extends StatelessWidget {
  GroupListViewDemo({Key? key}) : super(key: key);
  final myController = Get.put(MyController());
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "주문내역",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => GroupedListView<dynamic, String>(
          elements: myController.myRestaurant.value,
          groupBy: (item) {
            var now = DateTime.now();
            String date = "오래전";
            String formatDate = DateFormat('yyyy-MM-dd').format(now);
            if (item.date == formatDate) date = "오늘";
            var yesterday = DateTime(now.year, now.month, now.day - 1);
            formatDate = DateFormat('yyyy-MM-dd').format(yesterday);
            if (item.date == formatDate) date = "어제";
            for (int i = 2; i <= 31; i++) {
              var week = DateTime(now.year, now.month, now.day - i);
              formatDate = DateFormat('yyyy-MM-dd').format(week);
              if (item.date == formatDate) {
                if (i >= 2 && i <= 7) date = "일주일전";
                if (i > 7 && i <= 31) date = "한달전";
              }
            }
            return date;
          },
          order: GroupedListOrder.ASC,
          groupComparator: ((a, b) {
            int x = 0, y = 0;
            if (a == "오래전") {
              x = 4;
            } else if (a == "한달전") {
              x = 3;
            } else if (a == "일주일전") {
              x = 2;
            } else if (a == "어제") {
              x = 1;
            } else if (a == "오늘") {
              x = 0;
            }
            if (b == "오래전") {
              y = 4;
            } else if (b == "한달전") {
              y = 3;
            } else if (b == "일주일전") {
              y = 2;
            } else if (b == "어제") {
              y = 1;
            } else if (b == "오늘") {
              y = 0;
            }
            return x - y;
          }),
          groupSeparatorBuilder: (groupValue) {
            count = 0;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            groupValue,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.orange),
                        ),
                        const Expanded(
                          child: Divider(color: Colors.orange),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          itemBuilder: (context, index) {
            count++;
            return Column(
              children: [
                count == 2 ? Divider() : Container(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ChatRoom(), arguments: index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, right: 14.0),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: Image.network(
                                    index.imgUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext? context,
                                        Object? exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 3),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              'assets/hanbab_icon.png',
                                              scale: 5,
                                            )),
                                      );
                                    },
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 7,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 8, left: 13, top: 13),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 6),
                                          child: Text(
                                            index.groupName,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 5, bottom: 10),
                                          child: Text(
                                            ' ${index.currPeople}/${index.maxPeople}명',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            String.fromCharCode(CupertinoIcons
                                                .person.codePoint),
                                            style: TextStyle(
                                              inherit: false,
                                              color: const Color(0xff717171),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: CupertinoIcons
                                                  .person.fontFamily,
                                              package: CupertinoIcons
                                                  .person.fontPackage,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              getName(index.admin),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            color: Color(0xff717171),
                                            size: 13,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              index.date,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                count != 1 ? Divider() : Container()
              ],
            );
          },
          itemComparator: (item1, item2) => item2.date.compareTo(item1.date),
          useStickyGroupSeparators: true,
          floatingHeader: false,
        ),
      ),
    );
  }
}
