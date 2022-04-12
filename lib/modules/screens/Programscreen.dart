import 'package:fastaval_app/config/models/activity.dart';
import 'package:fastaval_app/config/models/activity_item.dart';
import 'package:fastaval_app/config/models/activity_run.dart';
import 'package:intl/intl.dart';

import 'package:fastaval_app/config/models/program.dart';
import 'package:flutter/material.dart';
import 'package:fastaval_app/utils/services/rest_api_service.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://infosys-test.fastaval.dk/api';

Future<List<ActivityItem>> getProgram() async {
  var url = Uri.parse('$baseUrl/app/v2/activities/*');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ActivityItem.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to download programs');
  }
}

Future<List<ActivityItem>> getday(String isoDate) async {
  var url = Uri.parse('$baseUrl/app/v3/activities/$isoDate');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ActivityItem.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to download programs');
  }
}

class Programscreen extends StatefulWidget {
  const Programscreen({Key? key}) : super(key: key);

  @override
  State<Programscreen> createState() => _ProgramscreenState();
}

class _ProgramscreenState extends State<Programscreen> {
  late Future<List<ActivityItem>> futureProgram;
  late List<ActivityItem> list;
  @override
  void initState() {
    super.initState();
    futureProgram = getProgram();

    futureProgram.then((List<ActivityItem> value) {
      list = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(text: "ons"),
            Tab(text: "tors"),
            Tab(text: "fre"),
            Tab(text: "lør"),
            Tab(text: "søn"),
          ],
        ),
        body: TabBarView(
          children: [
            buildday("2022-04-13"),
            buildday("2022-04-14"),
            buildday("2022-04-15"),
            buildday("2022-04-16"),
            buildday("2022-04-17"),
          ],
        ),
      ),
    );
  }

  Widget buildday(String day) {
    List<ActivityItem> _list = [];
    List<ActivityRun>? _runlist = [];
    Map<int, ActivityItem> _activityMap = <int, ActivityItem>{};
    getday(day).then((List<ActivityItem> value) {
      _list = value;

      for (ActivityItem ac in _list) {
        if (ac.type != 'system') {
          _activityMap.putIfAbsent(ac.id, () => ac);
          for (ActivityRun run in ac.runs) {
            if (unixtodatetime(run.start).toString().substring(0, 10) == day) {
              _runlist.add(run);
            }
          }
        }
      }
      _runlist.sort((a, b) => a.start - b.start);
    });

    return FutureBuilder(
      builder: (context, programSnap) {
        return SizedBox(
          child: Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: _runlist.length,
                itemBuilder: (context, index) {
                  ActivityRun item = _runlist[index];
                  return Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            //when

                            timebox(timestamp: unixtodatetime(item.start)),
                            Padding(padding: EdgeInsets.only(left: 20)),

                            //what
                            Text(
                              _activityMap[item.activity]!.daTitle,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(height: 6)
                      ],
                    ),
                  );
                },
              )),
        );
      },
      future: getday('2022-04-13'),
    );
  }

  Widget box({width: 100.0, height: 50.0}) => Container(
        width: width,
        height: height,
        color: Colors.grey,
      );

//tid   titel   hvor
  Widget _buildsession() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        //when
        timebox(timestamp: DateTime.now()),
        //what
        Text('hvad'),

        //where
        Text('hvor'),
      ],
    );
  }

  Widget timebox({required DateTime timestamp}) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Container(
          child: Text(
            DateFormat.Hm().format(timestamp),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
}

DateTime unixtodatetime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime * 1000);
}
