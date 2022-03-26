import 'food.dart';
import 'otto_party.dart';
import 'scheduling.dart';
import 'sleep.dart';
import 'wear.dart';

class User {
  String? id;
  String? name;
  int? checkedIn;
  String? messages;
  int? sleep;
  String? category;
  List<Food>? food;
  List<Wear>? wear;
  List<Scheduling>? scheduling;
  String? barcode;
  List<OttoParty>? ottoParty;

  User(
      {this.id,
      this.name,
      this.checkedIn,
      this.messages,
      this.sleep,
      this.category,
      this.food,
      this.wear,
      this.scheduling,
      this.barcode,
      this.ottoParty});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    checkedIn = json['checked_in'];
    messages = json['messages'] ?? '';
    sleep = json['sleep'];
    category = json['category'];
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(Food.fromJson(v));
      });
    }
    if (json['wear'] != null) {
      wear = <Wear>[];
      json['wear'].forEach((v) {
        wear!.add(Wear.fromJson(v));
      });
    }
    if (json['scheduling'] != null) {
      scheduling = <Scheduling>[];
      json['scheduling'].forEach((v) {
        scheduling!.add(Scheduling.fromJson(v));
      });
    }
    barcode = json['barcode'];
    if (json['otto_party'] != null) {
      ottoParty = <OttoParty>[];
      json['otto_party'].forEach((v) {
        ottoParty!.add(OttoParty.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['checked_in'] = this.checkedIn;
    data['messages'] = this.messages;
    if (this.sleep != null) {
      data['sleep'] = this.sleep;
    }
    data['category'] = this.category;
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    if (this.wear != null) {
      data['wear'] = this.wear!.map((v) => v.toJson()).toList();
    }
    if (this.scheduling != null) {
      data['scheduling'] = this.scheduling!.map((v) => v.toJson()).toList();
    }
    data['barcode'] = this.barcode;
    if (this.ottoParty != null) {
      data['otto_party'] = this.ottoParty!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
