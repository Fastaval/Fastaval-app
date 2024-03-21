import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/program.controller.dart';
import 'package:fastaval_app/helpers/collections.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramScreen extends StatelessWidget {
  final programCtrl = Get.find<ProgramController>();

  @override
  Widget build(context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorOrangeDark,
            foregroundColor: colorWhite,
            toolbarHeight: 25,
            centerTitle: true,
            titleTextStyle: kAppBarTextStyle,
            title: Text(tr('screenTitle.program')),
            bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(
                  color: colorWhite,
                  child: _tabBar,
                )),
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
        ));
  }

  TabBar get _tabBar => TabBar(
        labelColor: colorBlack,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: colorOrange,
        tabs: [
          Tab(text: tr('program.wednesday.short')),
          Tab(text: tr('program.thursday.short')),
          Tab(text: tr('program.friday.short')),
          Tab(text: tr('program.saturday.short')),
          Tab(text: tr('program.sunday.short')),
        ],
      );

  Widget buildday(String day) {
    return ListView.builder(
      itemCount: programCtrl.runList[day]!.length,
      itemBuilder: (context, index) {
        ActivityRun item = programCtrl.runList[day]![index];
        return InkWell(
          child: programListItem(programCtrl.activityMap[item.activity]!, item,
              getActivityColor(programCtrl.activityMap[item.activity]!.type)),
          onTap: () => showDialog(
            context: context,
            builder: programItemDialog,
            routeSettings: RouteSettings(
              arguments: [item, programCtrl.activityMap[item.activity]],
            ),
          ),
        );
      },
    );
  }

  Widget programItemDialog(BuildContext context) {
    ScrollController scrollController = ScrollController();
    var [ActivityRun item, ActivityItem details] =
        ModalRoute.of(context)!.settings.arguments as List;

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
      backgroundColor: colorWhite,
      surfaceTintColor: colorWhite,
      titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      title: Column(
        children: [
          Text(
            Get.locale?.languageCode == 'da'
                ? details.daTitle
                : details.enTitle,
            textAlign: TextAlign.center,
          ),
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
            Text('${details.playHours.toInt()} '),
            Text(
                details.playHours == 1 ? tr('common.hour') : tr('common.hours'))
          ]),
          SizedBox(height: 8),
          Row(children: [
            Text('${tr('common.players')}: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${details.minPlayers} - ${details.maxPlayers}'),
          ]),
          SizedBox(height: 8),
          Row(children: [
            Text('${tr('common.language')}: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(getLanguage(details.language)),
          ]),
          SizedBox(height: 8),
          Row(children: [
            Text('${tr('common.place')}: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(item.localeName),
          ]),
          SizedBox(height: 8),
          Text('${tr('common.description')}:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                controller: scrollController,
                child: Text(
                  Get.locale?.languageCode == 'da'
                      ? details.daText
                      : details.enText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
