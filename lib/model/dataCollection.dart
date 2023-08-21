class DataCollection {
  DataCollection({
    required this.id,
    required this.date,
    required this.staffId,
    required this.invoiceNum,
    required this.qty,
    required this.amount,
  });

  int id;
  String date;
  int staffId;
  int invoiceNum;
  int qty;
  int amount;

  factory DataCollection.fromJson(Map<String, dynamic> json) => DataCollection(
        id: json["id"],
        date: json["date"],
        staffId: json["staffId"],
        invoiceNum: json["invoiceNum"],
        qty: json["qty"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "staffId": staffId,
        "invoiceNum": invoiceNum,
        "qty": qty,
        "amount": amount,
      };
}
