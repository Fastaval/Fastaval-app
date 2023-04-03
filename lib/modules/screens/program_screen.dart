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
            Tab(text: tr('program.wednesday.short')),
            Tab(text: tr('program.thursday.short')),
            Tab(text: tr('program.friday.short')),
            Tab(text: tr('program.saturday.short')),
            Tab(text: tr('program.sunday.short')),
          ],
        ),
        body: TabBarView(
          children: [
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

    colorMap.putIfAbsent('rolle', () => Colors.lightGreen.shade300);
    colorMap.putIfAbsent('braet', () => Colors.blue.shade300);
    colorMap.putIfAbsent('live', () => Colors.teal.shade400);
    colorMap.putIfAbsent('ottoviteter', () => Colors.orangeAccent.shade400);
    colorMap.putIfAbsent('junior', () => Colors.pink.shade300);
    colorMap.putIfAbsent('magic', () => Colors.purpleAccent.shade100);
    colorMap.putIfAbsent('workshop', () => Colors.amberAccent.shade200);
    colorMap.putIfAbsent('figur', () => Colors.red.shade300);

    return FutureBuilder(
        future: activityList,
        builder: (context, programSnap) {
          List<Widget> children;
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
                                      color: colorMap[
                                              activityMap[item.activity]!.type]
                                          as Color),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 20)),

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
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10))
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
          } else if (programSnap.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${programSnap.error}'),
              ),
            ];
          } else {
            children = <Widget>[
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
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
              children: children,
            ),
          );
        });
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
      title: Text(
        context.locale.toString() == 'en' ? activity.enTitle : activity.daTitle,
        style: const TextStyle(fontSize: 18),
      ),
      content: Text(
        context.locale.toString() == 'en'
            ? activity.daDescription
            : activity.daDescription,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
