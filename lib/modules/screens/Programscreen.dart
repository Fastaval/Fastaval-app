import 'package:fastaval_app/config/models/activity.dart';
import 'package:fastaval_app/config/models/activity_item.dart';
import 'package:intl/intl.dart';

import 'package:fastaval_app/config/models/program.dart';
import 'package:flutter/material.dart';
import 'package:fastaval_app/utils/services/rest_api_service.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<ActivityItem>> getProgram() async {
  var url = Uri.parse('https://infosys.fastaval.dk/api/app/v2/activities/*');

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
    return FutureBuilder(
      builder: (context, programSnap) {
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: const TabBar(
              tabs: [
                Tab(text: "ons"),
                Tab(text: "tors"),
                Tab(text: "fre"),
                Tab(text: "lør"),
                Tab(text: "søn"),
                Tab(text: "man"),
              ],
            ),
            body: TabBarView(
              children: [
                _buildOnsdag(),
                Center(child: Text("torsdag")),
                Center(child: Text("fredag")),
                Center(child: Text("lørdag")),
                Center(child: Text("søndag")),
                Center(child: Text("mandag")),
              ],
            ),
          ),
        );
      },
      future: getProgram(),
    );
  }

  Widget _buildOnsdag() {
    return SizedBox(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              ActivityItem item = list[index];
              return Column(
                children: <Widget>[Text(item.daTitle)],
              );
            },
          )),
    );
  }
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

Widget timebox(
        {double? width = 100,
        double? height = 50,
        required DateTime timestamp}) =>
    Container(
      width: width,
      height: height,
      color: Colors.grey,
      child: Text(DateFormat.yMMMMEEEEd().format(timestamp)),
    );
