import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/boardgame.controller.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/boardgame.model.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardgameScreen extends GetView<BoardGameController> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 40,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('boardgames.title')),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: backgroundBoxDecorationStyle,
            child: RefreshIndicator(
              backgroundColor: colorWhite,
              color: colorOrange,
              onRefresh: () async {
                controller.getBoardGames();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Container(
                          height: 40, // Set the desired height here
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                controller.applyFilterToList(value),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: tr("boardgames.search"),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => {
                                  _searchController.clear(),
                                  controller.applyFilterToList()
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        )),
                    Obx(() => textAndTextCard(
                        tr('boardgames.title'),
                        "${tr('common.updated')} ${formatDay(controller.boardgameListUpdatedAt.value)} ${formatTime(controller.boardgameListUpdatedAt.value)}",
                        Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: buildGameList(context)))),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildGameList(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.filteredList.length,
      separatorBuilder: (context, int index) {
        return Divider(height: 0, color: Colors.grey);
      },
      itemBuilder: (buildContext, index) {
        return boardGameItem(controller.filteredList[index]);
      },
    );
  }

  Widget boardGameItem(Boardgame game) {
    return Container(
        color: !game.available ? Colors.red[100] : null,
        child: Column(children: [
          SizedBox(height: 10),
          InkWell(
              onTap: () => _launchDDB(game.bbgId),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(game.name,
                              style: kNormalTextBoldStyle,
                              overflow: TextOverflow.ellipsis),
                          Row(children: [
                            Text(tr(
                                "boardgames.gameAvailable.${game.available}")),
                            if (game.fastavalGame == true)
                              Text(" - ${tr('boardgames.fastavalGame')}"),
                          ]),
                        ])),
                    if (game.bbgId > 0)
                      Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Icon(Icons.public)),
                  ])),
          SizedBox(height: 10)
        ]));
  }

  _launchDDB(int gameID) async {
    if (gameID > 0) {
      final url = Uri.parse('https://boardgamegeek.com/boardgame/$gameID');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch website';
      }
    }
  }
}
