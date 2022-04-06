class Sleep {
  int? id;
  int? access;
  int? mattress;
  String? areaName;
  String? areaId;

  Sleep({this.id, this.access, this.mattress, this.areaName, this.areaId});

  Sleep.fromJson(dynamic json) {
    id = json['id'];
    access = json['access'];
    mattress = json['mattress'];
    areaName = json['area_name'];
    areaId = json['area_id'];
  }
}