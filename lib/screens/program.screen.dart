import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/helpers/collections.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/services/activities.service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Programscreen extends StatefulWidget {
  const Programscreen({Key? key}) : super(key: key);

  @override
  State<Programscreen> createState() => _ProgramscreenState();
}

class _ProgramscreenState extends State<Programscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: tr('program.wednesday.short')),
            Tab(text: tr('program.thursday.short')),
            Tab(text: tr('program.friday.short')),
            Tab(text: tr('program.saturday.short')),
            Tab(text: tr('program.sunday.short')),
          ],
        ),
        body: TabBarView(
          children: [
            buildday("2024-03-27"),
            buildday("2024-03-28"),
            buildday("2024-03-29"),
            buildday("2024-03-30"),
            buildday("2024-03-31"),
          ],
        ),
      ),
    );
  }

  Widget buildday(String day) {
    List<ActivityRun>? runlist = [];
    Map<int, ActivityItem> activityMap = <int, ActivityItem>{};

    final Future<List<ActivityItem>> activityList =
        getDay(day).then((List<ActivityItem> list) {
      for (ActivityItem activity in list) {
        if (activity.type != 'system') {
          activityMap.putIfAbsent(activity.id, () => activity);
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
      return list;
    });

    return FutureBuilder(
        future: activityList,
        builder: (context, programSnap) {
          List<Widget> screenState;
          if (programSnap.hasData) {
            return SizedBox(
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    itemCount: runlist.length,
                    itemBuilder: (context, index) {
                      ActivityRun item = runlist[index];
                      return InkWell(
                        child: programListItem(
                            activityMap[item.activity]!,
                            item,
                            getActivityColor(activityMap[item.activity]!.type)),
                        onTap: () => showDialog(
                            context: context,
                            builder: activityDialog,
                            routeSettings: RouteSettings(
                              arguments: activityMap[item.activity],
                            )),
                      );
                    },
                  )),
            );
          } else if (programSnap.hasError) {
            screenState = [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${programSnap.error}'),
              ),
            ];
          } else {
            screenState = [
              const SizedBox(
                  width: 60, height: 60, child: CircularProgressIndicator()),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(tr('program.loading'),
                    style: const TextStyle(fontSize: 18)),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: screenState,
            ),
          );
        });
  }

  Widget activityDialog(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as ActivityItem;
    return AlertDialog(
      title: Text(
        context.locale.toString() == 'da' ? activity.daTitle : activity.enTitle,
        style: const TextStyle(fontSize: 18),
      ),
      content: Text(
        context.locale.toString() == 'da'
            ? activity.daDescription
            : activity.enDescription,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
