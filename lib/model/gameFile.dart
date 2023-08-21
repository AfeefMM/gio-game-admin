class GameFile {
  GameFile({
    required this.gameID,
    required this.gameName,
    required this.fromDate,
    required this.toDate,
    required this.areaName,
    required this.storeCode,
    required this.gameValue,
  });

  int gameID;
  String gameName;
  String fromDate;
  String areaName;
  String toDate;
  String storeCode;
  String gameValue;

  factory GameFile.fromJson(Map<String, dynamic> json) => GameFile(
        gameID: json["gameID"],
        gameName: json["gameName"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        storeCode: json["storeCode"],
        areaName: json["areaName"],
        gameValue: json["gameValue"],
      );

  Map<String, dynamic> toJson() => {
        "gameID": gameID,
        "gameName": gameName,
        "fromDate": fromDate,
        "toDate": toDate,
        "areaName": areaName,
        "storeCode": storeCode,
        "gameValue": gameValue,
      };
}
