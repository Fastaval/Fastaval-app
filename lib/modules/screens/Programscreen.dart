import 'package:fastaval_app/config/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:fastaval_app/utils/services/rest_api_service.dart';

class Programscreen extends StatefulWidget {
  const Programscreen({Key? key}) : super(key: key);

  @override
  State<Programscreen> createState() => _ProgramscreenState();
}

class _ProgramscreenState extends State<Programscreen> {
  late Future<Activity> futureProgram;

  @override
  void initState() {
    super.initState();
    futureProgram = getProgram();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, programSnap) {
        if (programSnap.connectionState == ConnectionState.none ||
            !programSnap.hasData) {
          return Container();
        }
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: const TabBar(
              tabs: [
                Tab(text: "onsdag"),
                Tab(text: "torsdag"),
                Tab(text: "fredag"),
                Tab(text: "lørdag"),
                Tab(text: "søndag"),
                Tab(text: "mandag"),
              ],
            ),
            body: TabBarView(
              children: [
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
}
