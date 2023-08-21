class ResultFile {
  ResultFile({
    required this.gameId,
    required this.staffId,
    required this.score,
    required this.qty,
    required this.amount,
  });

  int gameId;
  int staffId;
  int score;
  int qty;
  int amount;

  factory ResultFile.fromJson(Map<String, dynamic> json) => ResultFile(
        gameId: json["gameId"],
        staffId: json["staffId"],
        score: json["score"],
        qty: json["qty"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "staffId": staffId,
        "score": score,
        "qty": qty,
        "amount": amount,
      };
}
