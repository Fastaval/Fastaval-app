import 'package:fastaval_app/models/activity.model.dart';

class Program {
  List<Activity>? activities;

  Program({this.activities});

  Program.fromJson(dynamic json) {
    activities = <Activity>[];
    for (var activity in json) {
      activities!.add(Activity.fromJson(activity));
    }
  }
}
