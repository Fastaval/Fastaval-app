import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/services/activities.service.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:get/get.dart';

class ProgramController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();
  final ActivitiesService activitiesService = ActivitiesService();

  Map<int, ActivityItem> activityMap = {};
  RxList favoritesList = [].obs;
  Map<String, List<ActivityItem>> programList = {};
  Map<String, List<ActivityRun>> runList = {};

  init() async {
    await addDayToList("2024-03-27");
    await addDayToList("2024-03-28");
    await addDayToList("2024-03-29");
    await addDayToList("2024-03-30");
    await addDayToList("2024-03-31");

    await getFavoritesFromStorage();
  }

  addDayToList(day) async {
    List<ActivityRun>? runlist = [];

    await activitiesService.getDay(day).then((list) {
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

  getFavoritesFromStorage() async {
    await activitiesService.retrieveFavorites().then((favorites) {
      favoritesList(favorites);
    });
  }

  toggleFavorite(int id) {
    favoritesList.contains(id)
        ? favoritesList.remove(id)
        : favoritesList.add(id);

    activitiesService.storeFavorites(favoritesList);
  }
}
