import 'dart:convert';

class Shops {
  Shops({
    required this.shopId,
    required this.shopArea,
  });

  String shopId;
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

List<Shops> shopsFromJson(String str) =>
    List<Shops>.from(json.decode(str).map((x) => Shops.fromJson(x)));

String shopsToJson(List<Shops> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
