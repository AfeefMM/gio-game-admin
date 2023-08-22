import 'dart:convert';

class Games {
  Games({
    required this.gameId,
    required this.gameName,
  });

  int gameId;
  String gameName;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        gameId: json["gameId"],
        gameName: json["gameName"],
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameName": gameName,
      };
}

List<Games> gamesFromJson(String str) =>
    List<Games>.from(json.decode(str).map((x) => Games.fromJson(x)));

String gamesToJson(List<Games> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
