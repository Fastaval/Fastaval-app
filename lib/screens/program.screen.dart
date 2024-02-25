import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/helpers/collections.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/services/activities.service.dart';
import 'package:fastaval_app/services/config.service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Programscreen extends StatefulWidget {
  const Programscreen({super.key});

  @override
  State<Programscreen> createState() => _ProgramscreenState();
}

class _ProgramscreenState extends State<Programscreen> {
  var currLang = ConfigService.instance.currLang;

  @override
  Widget build(context) {
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
                            arguments: [item, activityMap[item.activity]],
                          ),
                        ),
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
    var [ActivityRun item, ActivityItem details] =
        ModalRoute.of(context)!.settings.arguments as List;
    inspect(item);
    inspect(details);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        actionsPadding: EdgeInsets.all(5),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('common.close'))),
        ],
        titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        title: Column(
          children: [
            Text(currLang == 'da' ? details.daTitle : details.enTitle),
            if (details.author.isNotEmpty)
              Text(details.author,
                  style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('${tr('common.runtime')}: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${details.playHours.toInt()} timer'),
              ]),
              SizedBox(height: 5),
              Row(children: [
                Text('${tr('common.players')}: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${details.minPlayers} - ${details.maxPlayers}'),
              ]),
              SizedBox(height: 5),
              Row(children: [
                Text('${tr('common.language')}: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(details.language),
              ]),
              SizedBox(height: 5),
              Text(tr('common.description'),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    currLang == 'da' ? details.daText : details.enText,
                    style: TextStyle(fontFamily: 'OpenSans'),
                  ),
                ),
              )
            ]));
  }
}
