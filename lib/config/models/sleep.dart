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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['access'] = this.access;
    data['mattress'] = this.mattress;
    data['area_name'] = this.areaName;
    data['area_id'] = this.areaId;
    return data;
  }
}
