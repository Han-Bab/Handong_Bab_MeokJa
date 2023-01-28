import 'package:flutter/material.dart';
import 'package:han_bab/view/community/plus_page.dart';
import 'package:like_button/like_button.dart';

import '../main/community_page.dart';

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var title = [];

  get width => null;
  final myController = TextEditingController();
  final _commentFocusNode = FocusNode();
  final _commentTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '자유게시판',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.grey,
            elevation: 0,
            actions: <Widget>[
                  PopupMenuButton(
                      onSelected: (String value) {
                        // do something with the selected value here
                      },
                      itemBuilder: (BuildContext ctx) => [
                        const PopupMenuItem(
                          value: '1',
                          child: Text('수정'),
                        ),
                        const PopupMenuItem(value: '2', child: Text('삭제')),
                  ])
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: width,
                      child: const Text(
                        '방학에 학교에 남는 사람?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '물어볼 거 있는데 CRA 같은 전산 동아리에서 하는 '
                          '방학 프로젝트 같은 거는 정확히 어떤 걸 하고 '
                          '얼마나 시간을 들여야 가능해?',
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const LikeButton(
                          size: 30,
                          likeCount: 0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        LikeButton(
                          size: 30,
                          likeCount: 0,
                          likeBuilder: (isTapped) {
                            return Icon(
                              Icons.chat_bubble_outline_outlined,
                              color: isTapped ? Colors.black54 : Colors.grey,
                            );
                          },
                        )
                      ],
                    ),

                  ],
                ),
                GestureDetector(
                  child: Container(
                    child: TextFormField(
                      focusNode: _commentFocusNode,
                      controller: _commentTextEditController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return '댓글을 입력하세요.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        hintText: "댓글을 입력하세요.",
                        hintStyle: new TextStyle(color: Colors.black26),
                        suffixIcon:  IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {

                          },
                        ),
                        isDense: true,
                      ),

                    ),
                  ),
                ),

              ],
            ),
          ))
    );
  }
}
