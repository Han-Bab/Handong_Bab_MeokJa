import 'package:flutter/material.dart';

class ChatList extends StatelessWidget{
  const ChatList({Key? key}) : super(key: key);

  static final titleList = ['a','b','c','d','e','f','g','h','i','j'];
  static final description = ['1','2','3','4','5','6','7','8','9','10'];
  static final imageList = [
    'assets/image/1.jpg',
    'assets/image/2.jpg',
    'assets/image/3.jpg',
    'assets/image/4.jpg',
    'assets/image/5.jpg',
    'assets/image/6.jpg',
    'assets/image/7.jpg',
    'assets/image/8.jpg',
    'assets/image/9.jpg',
    'assets/image/10.jpg'
  ];

  void nextPage(context, title, image, description){ // 상세 페이지 넘겨주기
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 380,
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(10),
              color: Colors.white
            ),
          ),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

        return Scaffold(
          appBar: AppBar(
             title: const Text(
               'ListView',
               style: TextStyle(color: Colors.grey),
              ),
            backgroundColor: Colors.white,
            elevation: 0, //appbar 경계선
          ),
          body: ListView.builder(
              itemCount: titleList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    debugPrint(titleList[index]);
                    nextPage(context, titleList[index], imageList[index], description[index]);
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
                           child: Column(
                             children: [
                               Text(titleList[index],
                               style: const TextStyle(
                                 fontSize: 22,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.grey),
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               SizedBox(
                                 width: width,
                                 child: Center(
                                   child: Text(description[index],
                                     style: TextStyle(
                                       fontSize: 15,
                                       color: Colors.grey[500]
                                     ),
                                   ),
                                 ),
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
