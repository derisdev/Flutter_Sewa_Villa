class Activity {
  int id;
  String imageUrl;
  String name;
  String type;
  String startTimes;
  String rating;
  String price;

  Activity({
    this.id,
    this.imageUrl,
    this.name,
    this.type,
    this.startTimes,
    this.rating,
    this.price,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        type: json["type"],
        startTimes: json["startTimes"],
        rating: json["rating"],
        price: json["price"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "type": type,
        "startTimes": startTimes,
        "rating": rating,
        "price": price
      };
}
