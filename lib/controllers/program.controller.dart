import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/services/activities.service.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:get/get.dart';

class ProgramController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();

  Map<int, ActivityItem> activityMap = {};
  Map<String, List<ActivityItem>> programList = {};
  Map<String, List<ActivityRun>> runList = {};

  init() async {
    await addDayToList("2024-03-27");
    await addDayToList("2024-03-28");
    await addDayToList("2024-03-29");
    await addDayToList("2024-03-30");
    await addDayToList("2024-03-31");
  }

  addDayToList(day) async {
    List<ActivityRun>? runlist = [];

    await getDay(day).then((list) {
      for (ActivityItem activity in list) {
        if (activity.type != 'system') {
          activityMap[activity.id] = activity;
          for (ActivityRun run in activity.runs) {
            if (formatTimestampToDateTime(run.start)
                    .toString()
                    .substring(0, 10) ==
                day) {
              runlist.add(run);
            }
          }
        }
      }

      runlist.sort((a, b) => a.start - b.start);

      runList[day] = runlist;
      programList[day] = list;
    });
  }
}
