class OttoParty {
  String? id;
  String? titleEn;
  String? titleDa;
  int? amount;

  OttoParty({this.id, this.titleEn, this.titleDa, this.amount});

  OttoParty.fromJson(dynamic json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleDa = json['title_da'];
    amount = json['amount'];
  }
}
