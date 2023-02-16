import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:han_bab/component/time_widget.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/order_time_button_controller.dart';
import 'package:han_bab/view/main/main_screen.dart';
import '../../component/database_service.dart';
import '../../controller/search_controller.dart';
import '../../model/search.dart';


class AddChatRoom extends StatelessWidget {
  AddChatRoom({Key? key}) : super(key: key);

  final TextEditingController _maxPeopleController = TextEditingController();
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  final authController = AuthController();
  final controller = Get.put(SearchController());
  final orderTimeController = Get.put(OrderTimeButtonController());
  final _formKey = GlobalKey<FormState>();
  String pickup = "";
  String maxPeople = "";
  String imgUrl = "";
  String restaurant = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "밥채팅 만들기",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: ListView(
            shrinkWrap: true,
            children: [
              DottedBorder(
                color: Colors.grey,
                dashPattern: const [5, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                child: SizedBox(
                  width: 400,
                  height: 200,
                  child: Image.network(imgUrl,
                      fit: BoxFit.cover, errorBuilder:
                          (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                    return Image.asset("assets/hanbab_icon.png",
                        fit: BoxFit.fitHeight);
                  }),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Autocomplete<RestaurantName>(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text != "") {
                          return controller.countryNames.where((RestaurantName country) => country
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
                        return TextFormField(
                          decoration: InputDecoration(
                            hintText: '가게명을 입력해주세요',
                            icon: const Icon(CupertinoIcons.search, color: Colors.black,),
                            iconColor: Colors.black,
                            hintStyle: Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle,
                            contentPadding: const EdgeInsets.all(16),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 3, color: Colors.grey),
                            ),
                          ),
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '가게명을 입력하세요.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) async {
                            restaurant = value;
                            String newName = DatabaseService().getImage(value);
                            var urlRef = firebaseStorage.child('$newName.jpg');
                            imgUrl = await urlRef.getDownloadURL();
                          },
                        );
                      },
                      onSelected: (RestaurantName selection) async {
                        print('Selected: ${selection.name}');
                        restaurant = selection.name;
                        String newName = DatabaseService().getImage(selection.name);
                        var urlRef = firebaseStorage.child('$newName.jpg');
                        imgUrl = await urlRef.getDownloadURL();
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<RestaurantName>
                          onSelected,
                          Iterable<RestaurantName> country) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                width: MediaQuery.of(context).size.width *
                                    0.79,
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
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TimerWidget(16),
                    const SizedBox(
                      height: 25,
                    ),
                    //TODO: 계좌번호 사용 금지
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: OutlinedButton(
                    //         onPressed: null,
                    //         child: Text(
                    //           accountNumber,
                    //           style: TextStyle(color: Colors.blueAccent),
                    //         ),
                    //         style: OutlinedButton.styleFrom(
                    //           side: BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       style: ElevatedButton.styleFrom(
                    //           padding:
                    //               const EdgeInsets.fromLTRB(10, 0, 10, 0)),
                    //       child: const Text(
                    //         "계좌 변경",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    TextFormField(
                      onChanged: (value) {
                        pickup = value;
                      },
                      decoration: InputDecoration(
                        hintText: "예) 비전관, 오석관 등",
                        icon: const Icon(Icons.delivery_dining, color: Colors.black,),
                        iconColor: Colors.black,
                        hintStyle: Theme.of(context)
                            .inputDecorationTheme
                            .hintStyle,
                        contentPadding: const EdgeInsets.all(16),
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '수령할 장소를 입력하세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        maxPeople = value;
                      },
                      controller: _maxPeopleController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "예) 2, 3",
                        icon: const Icon(Icons.groups_rounded, color: Colors.black,),
                        iconColor: Colors.black,
                        hintStyle: Theme.of(context)
                            .inputDecorationTheme
                            .hintStyle,
                        contentPadding: const EdgeInsets.all(16),
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '최대 인원을 입력하세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.off(() => MainScreen());
                },
                child: const Text("취소하기"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey)
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    var result = await FirebaseFirestore.instance
                        .collection('user')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();
                    String userName = result['userName'];
                    String nickName = result['userNickName'];
                    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(
                            userName,
                            nickName,
                            FirebaseAuth.instance.currentUser!.uid,
                            restaurant.toUpperCase(),
                            orderTimeController.orderTime.value,
                            pickup,
                            maxPeople);
                    Get.snackbar(
                      '생성완료!',
                      '채팅방이 생성되었습니다!',
                      backgroundColor: Colors.white,
                      snackPosition: SnackPosition.BOTTOM
                    );
                    Get.to(() => MainScreen());
                  }
                },
                child: const Text("만들기"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
