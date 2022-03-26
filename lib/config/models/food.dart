class Food {
  int? time;
  int? timeEnd;
  String? titleDa;
  String? titleEn;
  String? foodId;
  String? timeId;
  String? textDa;
  String? textEn;

  Food(
      {this.time,
      this.timeEnd,
      this.titleDa,
      this.titleEn,
      this.foodId,
      this.timeId,
      this.textDa,
      this.textEn});

  Food.fromJson(dynamic json) {
    time = json['time'];
    timeEnd = json['time_end'];
    titleDa = json['title_da'];
    titleEn = json['title_en'];
    foodId = json['food_id'];
    timeId = json['time_id'];
    textDa = json['text_da'];
    textEn = json['text_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['time_end'] = this.timeEnd;
    data['title_da'] = this.titleDa;
    data['title_en'] = this.titleEn;
    data['food_id'] = this.foodId;
    data['time_id'] = this.timeId;
    data['text_da'] = this.textDa;
    data['text_en'] = this.textEn;
    return data;
  }
}
