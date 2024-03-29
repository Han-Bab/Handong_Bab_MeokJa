import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:han_bab/component/time_widget.dart';
import 'package:han_bab/controller/auth_controller.dart';
import 'package:han_bab/controller/order_time_button_controller.dart';
import 'package:han_bab/view/main/main_screen.dart';
import '../../component/customToolbarRect.dart';
import '../../component/database_service.dart';
import '../../controller/image_controller.dart';
import '../../controller/search_controller.dart';
import '../../model/search.dart';

class AddChatRoom extends StatelessWidget {
  AddChatRoom({Key? key}) : super(key: key);

  final TextEditingController _maxPeopleController = TextEditingController();
  final authController = AuthController();
  final controller = Get.put(SearchController());
  final orderTimeController = Get.put(OrderTimeButtonController());
  final _formKey = GlobalKey<FormState>();
  String pickup = "";
  String maxPeople = "";
  final imageController = Get.put(ImageController());
  String restaurant = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: CustomToolbarRect(
            title: "밥채팅 만들기",
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, spreadRadius: 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      width: 400,
                      height: 200,
                      child: Obx(
                        () => imageController.image.value
                                .contains("hanbab_icon.png")
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Image.asset("assets/vector.png", scale: 2,),
                                    Text(
                                      String.fromCharCode(
                                          CupertinoIcons.placemark.codePoint),
                                      style: TextStyle(
                                        inherit: false,
                                        color: Colors.grey[300],
                                        fontSize: 45.0,
                                        fontWeight: FontWeight.w100,
                                        fontFamily:
                                            CupertinoIcons.placemark.fontFamily,
                                        package:
                                            CupertinoIcons.placemark.fontPackage,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "일치하는 이미지가 없습니다",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(imageController.image.value,
                                  loadingBuilder: (BuildContext? context,
                                      Widget? child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child!;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          //Image.asset("assets/vector.png", scale: 2,),
                                          Text(
                                            String.fromCharCode(
                                                CupertinoIcons.placemark.codePoint),
                                            style: TextStyle(
                                              inherit: false,
                                              color: Colors.grey[300],
                                              fontSize: 45.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily:
                                                  CupertinoIcons.placemark.fontFamily,
                                              package: CupertinoIcons
                                                  .placemark.fontPackage,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "가게를 검색하세요",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                      ),
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
                              return controller.countryNames
                                  .where((RestaurantName country) => country.name
                                      .toLowerCase()
                                      .contains(
                                          textEditingValue.text.toLowerCase()))
                                  .toList();
                            } else {
                              return controller.countryNames
                                  .where((RestaurantName country) =>
                                      country.name.toLowerCase().contains("?"))
                                  .toList();
                            }
                          },
                          displayStringForOption: (RestaurantName country) =>
                              country.name,
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            return Focus(
                              onFocusChange: (bool hasFocus) {
                                restaurant = fieldTextEditingController.text;
                                imageController
                                    .searchImage(fieldTextEditingController.text);
                              },
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '가게명을 입력해주세요',
                                  icon: const Icon(
                                    CupertinoIcons.search,
                                    color: Color(0xff717171),
                                  ),
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                  contentPadding: const EdgeInsets.all(16),
                                  fillColor: Colors.transparent,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xffC2C2C2)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.black87),
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
                                textInputAction: TextInputAction.next,
                              ),
                            );
                          },
                          onSelected: (RestaurantName selection) async {
                            restaurant = selection.name;
                            imageController.searchImage(selection.name);
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<RestaurantName> onSelected,
                              Iterable<RestaurantName> country) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40.12),
                                  child: Container(
                                    transform: Matrix4.translationValues(0.0, -3.0, 0.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black87,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.745,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(1.0),
                                        itemCount: country.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final RestaurantName option =
                                              country.elementAt(index);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                            },
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        String.fromCharCode(
                                                            CupertinoIcons.placemark
                                                                .codePoint),
                                                        style: TextStyle(
                                                          inherit: false,
                                                          color: const Color(0xff919191),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily: CupertinoIcons
                                                              .placemark.fontFamily,
                                                          package: CupertinoIcons
                                                              .placemark
                                                              .fontPackage,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        option.name,
                                                        style: const TextStyle(
                                                            color:
                                                                Color(0xff919191),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                            hintText: "수령할 장소를 입력하세요",
                            icon: const Icon(
                              Icons.delivery_dining,
                              color: Color(0xff717171),
                            ),
                            hintStyle:
                                Theme.of(context).inputDecorationTheme.hintStyle,
                            contentPadding: const EdgeInsets.all(16),
                            fillColor: Colors.transparent,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffC2C2C2)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black87),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '수령할 장소를 입력하세요.';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
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
                            hintText: "최대 인원을 입력하세요",
                            icon: const Icon(
                              Icons.groups_rounded,
                              color: Color(0xff717171),
                            ),
                            hintStyle:
                                Theme.of(context).inputDecorationTheme.hintStyle,
                            contentPadding: const EdgeInsets.all(16),
                            fillColor: Colors.transparent,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffC2C2C2)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black87),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '최대 인원을 입력하세요.';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          imageController.removeData();
                          Get.off(() => MainScreen(),
                              transition: Transition.zoom);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: const BorderSide(width: 1, color: Color(0xffFC9729),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 15, bottom: 15),
                          child: Text("취소", style: TextStyle(color: Color(0xffFC9729), fontSize: 15),),
                        )),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var result = await FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth
                              .instance.currentUser!.uid)
                              .get();
                          String userName = result['userName'];
                          DatabaseService(
                              uid: FirebaseAuth
                                  .instance.currentUser!.uid)
                              .createGroup(
                              userName,
                              FirebaseAuth
                                  .instance.currentUser!.uid,
                              restaurant.toUpperCase(),
                              orderTimeController.orderTime.value,
                              pickup,
                              maxPeople);
                          Get.snackbar('생성완료!', '채팅방이 생성되었습니다!',
                              backgroundColor: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                          imageController.removeData();
                          Get.to(() => MainScreen(),
                              transition: Transition.zoom);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 15, bottom: 15),
                        child: Text("만들기", style: TextStyle(fontSize: 15),),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
