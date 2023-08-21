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
