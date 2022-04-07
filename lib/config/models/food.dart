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
}
