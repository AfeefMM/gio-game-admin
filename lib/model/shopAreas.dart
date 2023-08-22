import 'dart:convert';

class ShopAreas {
  ShopAreas({
    required this.id,
    required this.areaName,
  });

  int id;
  String areaName;

  factory ShopAreas.fromJson(Map<String, dynamic> json) => ShopAreas(
        id: json["id"],
        areaName: json["areaName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "areaName": areaName,
      };
}

List<ShopAreas> shopAreasFromJson(String str) =>
    List<ShopAreas>.from(json.decode(str).map((x) => ShopAreas.fromJson(x)));

String shopAreasToJson(List<ShopAreas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
