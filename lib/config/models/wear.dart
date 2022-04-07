class Wear {
  String? amount;
  String? size;
  String? titleDa;
  String? titleEn;
  String? wearId;
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
}
