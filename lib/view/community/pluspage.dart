import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlusPage extends StatefulWidget {
  const PlusPage({Key? key}) : super(key: key);

  @override
  State<PlusPage> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                print('search button is clicked');
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: '제목',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            height: 150,
            child: TextFormField(
              textInputAction: TextInputAction.go,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요.',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {
                print('camera button is clicked');
              },
              icon: const Icon(
                Icons.photo_camera,
                size: 35,
              ),
            ),
          ),
          //const Align(alignment: Alignment.bottomRight,),
          const SizedBox(
            width: 230,
          ),

          Checkbox(
              value: isChecked,
              activeColor: Colors.black,
              onChanged: (val) {
                setState(() {
                  if (val != null) isChecked = val;
                });
              }),
          const SizedBox(child: Text('익명')),
        ],
      ),
    );
  }
}
