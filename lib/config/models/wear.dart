class Wear {
  int? amount;
  int? size;
  String? titleDa;
  String? titleEn;
  int? wearId;
  int? received;

  Wear(
      {this.amount,
      this.size,
      this.titleDa,
      this.titleEn,
      this.wearId,
      this.received});

  Wear.fromJson(dynamic json) {
    amount = json['amount'];
    size = json['size'];
    titleDa = json['title_da'];
    titleEn = json['title_en'];
    wearId = json['wear_id'];
    received = json['received'];
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'size': size,
        'title_da': titleDa,
        'title_en': titleEn,
        'wear_id': wearId,
        'received': received
      };
}
