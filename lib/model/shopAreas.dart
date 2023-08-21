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
