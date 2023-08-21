class Shops {
  Shops({
    required this.shopId,
    required this.shopArea,
  });

  int shopId;
  String shopArea;

  factory Shops.fromJson(Map<String, dynamic> json) => Shops(
        shopId: json["shopId"],
        shopArea: json["shopArea"],
      );

  Map<String, dynamic> toJson() => {
        "shopId": shopId,
        "shopArea": shopArea,
      };
}
