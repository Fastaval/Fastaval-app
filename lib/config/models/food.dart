class Food {
  int? time;
  int? timeEnd;
  String? titleDa;
  String? titleEn;
  int? id;
  int? timeId;
  String? textDa;
  String? textEn;

  Food(
      {this.time,
      this.timeEnd,
      this.titleDa,
      this.titleEn,
      this.id,
      this.timeId,
      this.textDa,
      this.textEn});

  Food.fromJson(dynamic json) {
    time = json['time'];
    timeEnd = json['time_end'];
    titleDa = json['title_da'];
    titleEn = json['title_en'];
    id = json['food_id'];
    timeId = json['time_id'];
    textDa = json['text_da'];
    textEn = json['text_en'];
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'time_end': timeEnd,
        'title_da': titleDa,
        'title_en': titleEn,
        'food_id': id,
        'time_id': timeId,
        'text_da': textDa,
        'text_en': textEn
      };
}
