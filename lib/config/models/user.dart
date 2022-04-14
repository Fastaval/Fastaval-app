import 'package:fastaval_app/config/models/sleep.dart';

import 'food.dart';
import 'otto_party.dart';
import 'scheduling.dart';
import 'wear.dart';

class User {
  String? id;
  String? name;
  int? checkedIn;
  String? messages;
  Sleep? sleep;
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
    sleep = Sleep.fromJson(json['sleep']);
    category = json['category'];
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((foodItem) {
        food!.add(Food.fromJson(foodItem));
      });
    }
    if (json['wear'] != null) {
      wear = <Wear>[];
      json['wear'].forEach((wearItem) {
        wear!.add(Wear.fromJson(wearItem));
      });
    }
    if (json['scheduling'] != null) {
      scheduling = <Scheduling>[];
      json['scheduling'].forEach((shedulingtem) {
        scheduling!.add(Scheduling.fromJson(shedulingtem));
      });
    }
    barcode = json['barcode'];
    if (json['otto_party'] != null) {
      ottoParty = <OttoParty>[];
      json['otto_party'].forEach((ottoPartyItem) {
        ottoParty!.add(OttoParty.fromJson(ottoPartyItem));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'checked_in': checkedIn,
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
