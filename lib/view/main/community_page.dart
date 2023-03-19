import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/comment_controller.dart';
import 'package:han_bab/controller/community_controller.dart';
import '../../controller/content_controller.dart';
import '../community/content.dart';
import '../community/add_post.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({Key? key}) : super(key: key);
  final communityController = Get.put(CommunityController());
  final commentController = Get.put(CommentController());
  final contentController = Get.put(ContentController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '음식게시판',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0, // 경계선 없애는 늒임
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 500),
              () => communityController.getData()),
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
                  await communityController.getData();
                  communityController.update();
                },
                child: Stack(
                  children: [
                    GetBuilder<CommunityController>(
                      builder: (communityController) {
                        return ListView.builder(
                          itemCount: communityController.communityList.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                commentController.boardID =
                                    communityController.communityList[index].id;
                                contentController.contentUID =
                                    communityController
                                        .communityList[index].uid;
                                commentController.index = index;
                                contentController.contentID =
                                    communityController.communityList[index].id;
                                Get.to(() => Content(), arguments: index);
                              },
                              child: Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 15, 5, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.9,
                                            child: Text(
                                              communityController
                                                  .communityList[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: width * 0.9,
                                            child: Text(
                                              communityController
                                                  .communityList[index].content,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  child: communityController
                                                          .checkTime(index)
                                                      ? Text(
                                                          '${communityController.communityList[index].regtime} | ${communityController.communityList[index].writer}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        )
                                                      : Text(
                                                          '${communityController.communityList[index].regdate} | ${communityController.communityList[index].writer}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons
                                                            .heart_fill,
                                                        color: Colors.red,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          '${communityController.communityList[index].likeCount}'),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Icon(
                                                        CupertinoIcons
                                                            .chat_bubble_fill,
                                                        color: Colors.green,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          '${communityController.communityList[index].commentCount}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // 글 작성하기 버튼
                    Positioned(
                      bottom: 20,
                      child: SizedBox(
                        width: width,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Get.off(() => AddPost());
                            },
                            style: TextButton.styleFrom(
                              elevation: 2,
                              fixedSize: const Size(112, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: const BorderSide(color: Colors.orange),
                              backgroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.pencil,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '글 쓰기',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
