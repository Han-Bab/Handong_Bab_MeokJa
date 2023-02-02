import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/mychat_controller.dart';

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
  GroupListViewDemo({Key? key}) : super(key: key);
  final myController = Get.put(MyController());

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
      body: Obx(() => GroupedListView<dynamic, String>(
          elements: myController.myRestaurant.value,
          groupBy: (item) {
            var now = DateTime.now();
            String date = "오래전";
            String formatDate = DateFormat('yyyy/MM/dd').format(now);
            if (item.date == formatDate) date = "오늘";
            var yesterday = DateTime(now.year, now.month, now.day - 1);
            formatDate = DateFormat('yyyy/MM/dd').format(yesterday);
            if (item.date == formatDate) date = "어제";
            for (int i = 2; i <= 31; i++) {
              var week = DateTime(now.year, now.month, now.day - i);
              formatDate = DateFormat('yyyy/MM/dd').format(week);
              if (item.date == formatDate) {
                if (i >= 2 && i <= 7) date = "일주일전";
                if (i > 7 && i <= 31) date = "한달전";
              }
            }
            return date;
          },
          order: GroupedListOrder.ASC,
          groupComparator: ((a,b){
            int x =0,y=0;
            if(a == "오래전") {
              x = 4;
            } else if(a == "한달전") {
              x = 3;
            } else if(a == "일주일전") {
              x = 2;
            } else if(a == "어제") {
              x = 1;
            } else if(a == "오늘") {
              x = 0;
            }
            if(b == "오래전") {
              y = 4;
            } else if(b == "한달전") {
              y = 3;
            } else if(b == "일주일전") {
              y = 2;
            } else if(b == "어제") {
              y = 1;
            } else if(b == "오늘") {
              y = 0;
            }
            return x-y;
          }),
          groupSeparatorBuilder: (groupValue) => Padding(
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
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      const Expanded(
                        child: Divider(color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // debugPrint(item['name']);
                // nextPage(context, item['name'], item['image'], item['user']);
              },
              child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
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
                                borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                                child: Image.asset(
                                  index.imgUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 8,
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
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
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Text(
                                          index.orderTime,
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.account_circle_sharp,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          child: Text(index.admin),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              color: Colors.grey,
                                              size: 16,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(left: 8),
                                              child: Text(index.date),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 5),
                                        child: Row(
                                          children: [
                                            const Icon(CupertinoIcons.person),
                                            Text(
                                                '${index.currPeople}/${index.maxPeople}'),
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
              item2.date.compareTo(item1.date),
          useStickyGroupSeparators: true,
          floatingHeader: false,
        ),
      ),
    );
  }
}