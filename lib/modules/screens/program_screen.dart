import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/helpers/formatting.dart';
import 'package:fastaval_app/config/models/activity_item.dart';
import 'package:fastaval_app/config/models/activity_run.dart';
import 'package:fastaval_app/utils/services/activities_service.dart';
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
            Tab(text: tr('program.wednesday')),
            Tab(text: tr('program.thursday')),
            Tab(text: tr('program.friday')),
            Tab(text: tr('program.saturday')),
            Tab(text: tr('program.sunday')),
          ],
        ),
        body: TabBarView(
          children: [
            //TODO: make it so days are pulled from api
            buildday("2023-04-05"),
            buildday("2023-04-06"),
            buildday("2023-04-07"),
            buildday("2023-04-08"),
            buildday("2023-04-09"),
          ],
        ),
      ),
    );
  }

  Widget buildday(String day) {
    List<ActivityRun>? runlist = [];
    Map<int, ActivityItem> activityMap = <int, ActivityItem>{};
    Map<String, Color> colorMap = <String, Color>{};
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
    });
    colorMap.putIfAbsent('rolle', () => Colors.lightGreen.shade300);
    colorMap.putIfAbsent('braet', () => Colors.blue.shade300);
    colorMap.putIfAbsent('live', () => Colors.teal.shade400);
    colorMap.putIfAbsent('ottoviteter', () => Colors.orangeAccent.shade400);
    colorMap.putIfAbsent('junior', () => Colors.pink.shade300);
    colorMap.putIfAbsent('magic', () => Colors.purpleAccent.shade100);
    colorMap.putIfAbsent('workshop', () => Colors.amberAccent.shade200);
    colorMap.putIfAbsent('figur', () => Colors.red.shade300);
    return FutureBuilder(
      builder: (context, programSnap) {
        return SizedBox(
          child: Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: runlist.length,
                itemBuilder: (context, index) {
                  ActivityRun item = runlist[index];

                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //when
                              timeBox(
                                  timestamp:
                                      formatTimestampToDateTime(item.start),
                                  color:
                                      colorMap[activityMap[item.activity]!.type]
                                          as Color),
                              const Padding(padding: EdgeInsets.only(left: 20)),

                              //what
                              Flexible(
                                  child: Text(
                                context.locale.toString() == 'en'
                                    ? activityMap[item.activity]!.enTitle
                                    : activityMap[item.activity]!.daTitle,
                                style: const TextStyle(fontSize: 18),
                              )),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10))
                        ],
                      ),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: activtyDialog,
                        routeSettings: RouteSettings(
                          arguments: activityMap[item.activity],
                        )),
                  );
                },
              )),
        );
      },
    );
  }

  Widget timeBox({required DateTime timestamp, required Color color}) =>
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Text(
          DateFormat.Hm().format(timestamp),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      );

  Widget activtyDialog(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as ActivityItem;

    return AlertDialog(
      content: Text(
        context.locale.toString() == 'en' ? activity.enTitle : activity.daTitle,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
