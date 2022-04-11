import 'package:fastaval_app/config/models/program.dart';
import 'package:flutter/material.dart';
import 'package:fastaval_app/utils/services/rest_api_service.dart';

class Programscreen extends StatefulWidget {
  const Programscreen({Key? key}) : super(key: key);

  @override
  State<Programscreen> createState() => _ProgramscreenState();
}

class _ProgramscreenState extends State<Programscreen> {
  late Future<Program> futureProgram;
  Program? myprogram;
  @override
  void initState() {
    super.initState();
    futureProgram = fetchProgram();

    futureProgram.then((Program value) {
      myprogram = value;
    });
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
      future: fetchProgram(),
    );
  }

  Widget _buildOnsdag() {
    return SizedBox(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: _buildsession()),
    );
  }
}

//tid   titel   hvor
Widget _buildsession() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const <Widget>[
      //when
      Text('time'),

      //what
      Text('hvad'),

      //where
      Text('hvor'),
    ],
  );
}

