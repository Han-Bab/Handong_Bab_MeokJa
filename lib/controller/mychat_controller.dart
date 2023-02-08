import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';

class MyController extends GetxController {
  RxList<Restaurant> myRestaurant = <Restaurant>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    await Future.delayed(const Duration(seconds: 2));
    var restaurantData = [
      Restaurant(
          groupName: '류앤돈까스',
          imgUrl: 'assets/images/류엔돈까스.jpg',
          admin: 'zz',
          date: '2023/01/17',
          orderTime: '17:00',
          currPeople: "1",
          maxPeople: "4",
          pickup: "오석관",
          groupId: '', members: []
      ),
      Restaurant(
          groupName: '동궁찜닭',
          imgUrl: 'assets/images/동궁찜닭.jpg',
          admin: 'yy',
          date: '2023/01/06',
          orderTime: '13:00',
          currPeople: "2",
          maxPeople: "4",
          pickup: "오석관",
          groupId: '', members: []
      ),
      Restaurant(
          groupName: '꼬꼬뽀끼',
          imgUrl: 'assets/images/꼬꼬뽀끼.jpg',
          admin: 'xx',
          date: '2023/01/01',
          orderTime: '14:00',
          currPeople: "4",
          maxPeople: "4",
          pickup: "오석관",
          groupId: '', members: []
      ),
      Restaurant(
          groupName: 'bbq',
          imgUrl: 'assets/images/bbq.jpg',
          admin: 'w',
          date: '2022/12/11',
          orderTime: '11:00',
          currPeople: "3",
          maxPeople: "4",
          pickup: "오석관",
          groupId: '', members: []
      ),
      Restaurant(
          groupName: '행복한 마라탕',
          imgUrl: 'assets/images/행복한 마라탕.jpg',
          admin: 'v',
          date: '2023/01/30',
          orderTime: '14:00',
          currPeople: "2",
          maxPeople: "3",
          pickup: "오석관",
          groupId: '', members: []
      ),
      Restaurant(
          groupName: '삼촌네',
          imgUrl: 'assets/images/삼촌네.jpg',
          admin: 'oo',
          date: '2023/01/31',
          orderTime: '21:00',
          currPeople: "1",
          maxPeople: "2",
          pickup: "오석관",
          groupId: '', members: []
      ),
      // Restaurant(
      //     groupName: '신전 떡볶이',
      //     imgUrl: 'assets/images/신전떡볶이.jpg',
      //     admin: 'pp',
      //     date: '2023/01/08',
      //     orderTime: '22:00',
      //     currPeople: "2",
      //     maxPeople: "4",
      //     pickup: "오석관"
      //     groupId: ''
      // ),
      // Restaurant(
      //     id: 8,
      //     restaurantName: '명성',
      //     imgUrl: 'assets/images/명성.jpg',
      //     userName: 'qq',
      //     date: '2023/01/09',
      //     time: '23:00',
      //     currPeople: 1,
      //     maxPeople: 4,
      //     position: "오석관"
      // ),
      // Restaurant(
      //     id: 9,
      //     restaurantName: '땅땅치킨',
      //     imgUrl: 'assets/images/땅땅치킨.jpg',
      //     userName: 'rr',
      //     date: '2023/01/16',
      //     time: '23:20',
      //     currPeople: 1,
      //     maxPeople: 4,
      //     position: "오석관"
      // ),
      // Restaurant(
      //     id: 10,
      //     restaurantName: '행복한 마라탕',
      //     imgUrl: 'assets/images/스시요시.jpg',
      //     userName: 'ss',
      //     date: '2023/01/15',
      //     time: '14:20',
      //     currPeople: 1,
      //     maxPeople: 4,
      //     position: "오석관"
      // ),
    ];
    myRestaurant.assignAll(restaurantData);
  }
}