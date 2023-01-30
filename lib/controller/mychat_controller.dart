import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';

class MyController extends GetxController {
  RxList<Restaurant> myRestaurant = <Restaurant>[].obs;

  @override
  void onInit() {
    super.onInit();
    //fetchData();
  }

  // void fetchData() async{
  //   await Future.delayed(const Duration(seconds: 2));
  //   var restaurantData = [
  //     Restaurant(
  //         id: 1,
  //         restaurantName: '류앤돈까스',
  //         imgUrl: 'assets/images/류엔돈까스.jpg',
  //         userName: 'zz',
  //         date: '2023/01/17',
  //         time: '17:00',
  //         currPeople: 1,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 2,
  //         restaurantName: '동궁찜닭',
  //         imgUrl: 'assets/images/동궁찜닭.jpg',
  //         userName: 'yy',
  //         date: '2023/01/06',
  //         time: '13:00',
  //         currPeople: 2,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 3,
  //         restaurantName: '꼬꼬뽀끼',
  //         imgUrl: 'assets/images/꼬꼬뽀끼.jpg',
  //         userName: 'xx',
  //         date: '2023/01/01',
  //         time: '14:00',
  //         currPeople: 4,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 4,
  //         restaurantName: 'bbq',
  //         imgUrl: 'assets/images/bbq.jpg',
  //         userName: 'w',
  //         date: '2022/12/11',
  //         time: '11:00',
  //         currPeople: 3,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 5,
  //         restaurantName: '행복한 마라탕',
  //         imgUrl: 'assets/images/행복한 마라탕.jpg',
  //         userName: 'v',
  //         date: '2022/11/01',
  //         time: '14:00',
  //         currPeople: 2,
  //         maxPeople: 3,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 6,
  //         restaurantName: '삼촌네',
  //         imgUrl: 'assets/images/삼촌네.jpg',
  //         userName: 'oo',
  //         date: '2022/12/19',
  //         time: '21:00',
  //         currPeople: 1,
  //         maxPeople: 2,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 7,
  //         restaurantName: '신전 떡볶이',
  //         imgUrl: 'assets/images/신전떡볶이.jpg',
  //         userName: 'pp',
  //         date: '2023/01/08',
  //         time: '22:00',
  //         currPeople: 2,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 8,
  //         restaurantName: '명성',
  //         imgUrl: 'assets/images/명성.jpg',
  //         userName: 'qq',
  //         date: '2023/01/09',
  //         time: '23:00',
  //         currPeople: 1,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 9,
  //         restaurantName: '땅땅치킨',
  //         imgUrl: 'assets/images/땅땅치킨.jpg',
  //         userName: 'rr',
  //         date: '2023/01/16',
  //         time: '23:20',
  //         currPeople: 1,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //     Restaurant(
  //         id: 10,
  //         restaurantName: '행복한 마라탕',
  //         imgUrl: 'assets/images/스시요시.jpg',
  //         userName: 'ss',
  //         date: '2023/01/15',
  //         time: '14:20',
  //         currPeople: 1,
  //         maxPeople: 4,
  //         position: "오석관"
  //     ),
  //   ];
  //   myRestaurant.assignAll(restaurantData);
  // }
}