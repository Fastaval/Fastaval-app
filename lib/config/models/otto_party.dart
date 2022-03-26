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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_en'] = this.titleEn;
    data['title_da'] = this.titleDa;
    data['amount'] = this.amount;
    return data;
  }
}
