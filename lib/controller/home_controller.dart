import 'package:get/get.dart';
import 'package:han_bab/model/restaurant.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var restaurant = <Restaurant>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    await Future.delayed(const Duration(seconds: 3));
    var restaurantData = [
      Restaurant(
          id: 1,
          restaurantName: '류앤돈까스',
          imgUrl: 'assets/images/1.jpg',
          userName: 'aa',
          date: '2023/01/02',
          time: '17:00',
          currPeople: 1,
          maxPeople: 4,
          position: "오석관"
      ),
      Restaurant(
          id: 2,
          restaurantName: '동궁찜닭',
          imgUrl: 'assets/images/2.jpg',
          userName: 'bb',
          date: '2023/01/06',
          time: '13:00',
          currPeople: 2,
          maxPeople: 4,
          position: "로뎀관"
      ),
      Restaurant(
          id: 3,
          restaurantName: '꼬꼬뽀끼',
          imgUrl: 'assets/images/3.jpg',
          userName: 'cc',
          date: '2023/01/01',
          time: '15:00',
          currPeople: 4,
          maxPeople: 4,
          position: "하용조관"
      ),
      Restaurant(
          id: 4,
          restaurantName: 'bbq',
          imgUrl: 'assets/images/4.jpg',
          userName: 'dd',
          date: '2022/12/11',
          time: '10:00',
          currPeople: 3,
          maxPeople: 4,
          position: "비전관"
      ),
      Restaurant(
          id: 5,
          restaurantName: '행복한 마라탕',
          imgUrl: 'assets/images/5.jpg',
          userName: 'ee',
          date: '2022/11/01',
          time: '12:00',
          currPeople: 2,
          maxPeople: 3,
          position: "벧엘관"
      ),
      Restaurant(
          id: 6,
          restaurantName: '삼촌네',
          imgUrl: 'assets/images/6.jpg',
          userName: 'ff',
          date: '2022/12/19',
          time: '11:00',
          currPeople: 1,
          maxPeople: 2,
          position: "오석관"
      ),
      Restaurant(
          id: 7,
          restaurantName: '신전 떡볶이',
          imgUrl: 'assets/images/7.jpg',
          userName: 'gg',
          date: '2023/01/08',
          time: '12:00',
          currPeople: 2,
          maxPeople: 4,
          position: "오석관"
      ),
      Restaurant(
          id: 8,
          restaurantName: '명성',
          imgUrl: 'assets/images/8.jpg',
          userName: 'hh',
          date: '2023/01/09',
          time: '14:00',
          currPeople: 1,
          maxPeople: 4,
          position: "오석관"
      ),
      Restaurant(
          id: 9,
          restaurantName: '땅땅치킨',
          imgUrl: 'assets/images/9.jpg',
          userName: 'ii',
          date: '2023/01/16',
          time: '17:30',
          currPeople: 1,
          maxPeople: 4,
          position: "오석관"
      ),
      Restaurant(
          id: 10,
          restaurantName: '행복한 마라탕',
          imgUrl: 'assets/images/10.jpg',
          userName: 'jj',
          date: '2023/01/15',
          time: '13:40',
          currPeople: 1,
          maxPeople: 4,
          position: "오석관"
      ),
    ];
    restaurantData.sort((a,b) => DateFormat.Hm().parse(a.time).compareTo(DateFormat.Hm().parse(b.time)));
    restaurant.assignAll(restaurantData);
  }
}