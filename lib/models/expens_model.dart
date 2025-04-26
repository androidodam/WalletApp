class ExpensModel {
  String id;
  String title;
  String? image;
  DateTime? sana;
  double price;
  bool isPrice;

  ExpensModel({
    required this.id,
    required this.title,
    required this.image,
    required this.sana,
    required this.price,
    required this.isPrice,
  });

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "title": this.title,
        "image": this.image,
        "sana": this.sana?.toIso8601String(),
        "price": this.price,
        "isPrice": this.isPrice,
      };

  factory ExpensModel.fromJson(Map<String, dynamic> json) {
    return ExpensModel(
        id: json["id"].toString(),
        title: json["title"].toString(),
        image: json["image"],
        sana: json["sana"] != null ? DateTime.parse(json["sana"]) : null,
        price: json["price"],
        isPrice: bool.parse(json["isPrice"].toString()));
  }
}
