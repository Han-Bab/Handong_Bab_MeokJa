class Restaurant {
  final int id;
  final String restaurantName;
  final String imgUrl;
  final String userName;
  final String date;
  final String time;
  final int currPeople;
  final int maxPeople;
  final String position;

  Restaurant({
    required this.id,
    required this.restaurantName,
    required this.imgUrl,
    required this.userName,
    required this.date,
    required this.time,
    required this.currPeople,
    required this.maxPeople,
    required this.position
  });
}