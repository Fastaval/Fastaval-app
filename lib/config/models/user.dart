import 'package:fastaval_app/config/models/sleep.dart';

import 'food.dart';
import 'otto_party.dart';
import 'scheduling.dart';
import 'wear.dart';

class User {
  int? id;
  String? name;
  bool? hasCheckedIn;
  String? messages;
  Sleep? sleep;
  String? category;
  List<Food>? food;
  List<Wear>? wear;
  List<Scheduling>? scheduling;
  int? barcode;
  List<OttoParty>? ottoParty;

  User(
      {this.id,
      this.name,
      this.hasCheckedIn,
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
    hasCheckedIn = json['checked_in'] != 0;
    messages = json['messages'] ?? '';
    sleep = Sleep.fromJson(json['sleep']);
    category = json['category'];
    barcode = json['barcode'];

    var foodArray = json['food'] as List;
    food = foodArray.map((item) => Food.fromJson(item)).toList();

    var wearArray = json['wear'] as List;
    wear = wearArray.map((item) => Wear.fromJson(item)).toList();

    var schedulingArray = json['scheduling'] as List;
    scheduling = schedulingArray.map((item) => Scheduling.fromJson(item)).toList();

    var ottoPartyArray = json['otto_party'] as List;
    ottoParty = ottoPartyArray.map((item) => OttoParty.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'checked_in': hasCheckedIn,
        'messages': messages,
        'sleep': sleep,
        'category': category,
        'food': food,
        'wear': wear,
        'scheduling': scheduling,
        'barcode': barcode,
        'otto_party': ottoParty
      };
}
