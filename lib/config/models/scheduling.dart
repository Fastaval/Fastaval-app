class Scheduling {
  String? type;
  String? activityType;
  String? id;
  String? scheduleId;
  String? titleDa;
  String? titleEn;
  String? roomDa;
  String? roomEn;
  int? start;
  int? stop;
  String? playRoomId;
  String? playRoomName;
  String? meetRoomId;
  String? meetRoomName;

  Scheduling(
      {this.type,
      this.activityType,
      this.id,
      this.scheduleId,
      this.titleDa,
      this.titleEn,
      this.roomDa,
      this.roomEn,
      this.start,
      this.stop,
      this.playRoomId,
      this.playRoomName,
      this.meetRoomId,
      this.meetRoomName});

  Scheduling.fromJson(dynamic json) {
    type = json['type'];
    activityType = json['activity_type'];
    id = json['id'];
    scheduleId = json['schedule_id'];
    titleDa = json['title_da'];
    titleEn = json['title_en'];
    roomDa = json['room_da'];
    roomEn = json['room_en'];
    start = json['start'];
    stop = json['stop'];
    playRoomId = json['play_room_id'];
    playRoomName = json['play_room_name'];
    meetRoomId = json['meet_room_id'];
    meetRoomName = json['meet_room_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['activity_type'] = this.activityType;
    data['id'] = this.id;
    data['schedule_id'] = this.scheduleId;
    data['title_da'] = this.titleDa;
    data['title_en'] = this.titleEn;
    data['room_da'] = this.roomDa;
    data['room_en'] = this.roomEn;
    data['start'] = this.start;
    data['stop'] = this.stop;
    data['play_room_id'] = this.playRoomId;
    data['play_room_name'] = this.playRoomName;
    data['meet_room_id'] = this.meetRoomId;
    data['meet_room_name'] = this.meetRoomName;
    return data;
  }
}
