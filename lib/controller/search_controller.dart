import 'package:get/get.dart';
import '../model/search.dart';

class SearchController extends GetxController {
  late List<RestaurantName> countryNames;

  @override
  void onInit() {
    super.onInit();
    countryNames = <RestaurantName>[
      RestaurantName(name: "스시요시"),
      RestaurantName(name: "행복한 마라탕"),
      RestaurantName(name: "꼬꼬뽀끼"),
      RestaurantName(name: "BBQ"),
      RestaurantName(name: "땅땅치킨"),
      RestaurantName(name: "동궁찜닭"),
      RestaurantName(name: "명성"),
      RestaurantName(name: "류엔돈까스"),
      RestaurantName(name: "삼촌네"),
      RestaurantName(name: "신전떡볶이"),
      RestaurantName(name: "공차"),
    ];
  }
}