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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['size'] = this.size;
    data['title_da'] = this.titleDa;
    data['title_en'] = this.titleEn;
    data['wear_id'] = this.wearId;
    data['received'] = this.received;
    return data;
  }
}
