import 'dart:convert';

class GameFile {
  GameFile({
    required this.gameId,
    required this.gameName,
    required this.fromDate,
    required this.toDate,
    required this.areaName,
    required this.storeCode,
    required this.gameValue,
  });

  int? gameId;
  String? gameName;
  String? fromDate;
  String? areaName;
  String? toDate;
  String? storeCode;
  int? gameValue;

  factory GameFile.fromJson(Map<String, dynamic> json) => GameFile(
        gameId: json["gameId"],
        gameName: json["gameName"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        storeCode: json["storeCode"],
        areaName: json["areaName"],
        gameValue: json["gameValue"],
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameName": gameName,
        "fromDate": fromDate,
        "toDate": toDate,
        "areaName": areaName,
        "storeCode": storeCode,
        "gameValue": gameValue,
      };
}

List<GameFile> gameFileFromJson(String str) =>
    List<GameFile>.from(json.decode(str).map((x) => GameFile.fromJson(x)));

String gameFileToJson(List<GameFile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
