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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: backgroundBoxDecorationStyle,
              ),
              SizedBox(
                  height: double.infinity,
                  child: RefreshIndicator(
                    backgroundColor: colorWhite,
                    color: colorOrange,
                    onRefresh: () async {
                      controller.getBoardGames();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                              padding: kCardMargin,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) =>
                                    controller.applyFilterToList(value),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: tr("boardgames.search"),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => {
                                      _searchController.clear(),
                                      controller.applyFilterToList()
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )),
                          Obx(() => textAndTextCard(
                              tr('boardgames.title'),
                              "${tr('common.updated')} ${formatDay(controller.boardgameListUpdatedAt.value)} ${formatTime(controller.boardgameListUpdatedAt.value)}",
                              buildGameList(context))),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGameList(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.filteredList.length,
      prototypeItem: boardGameItem(controller.boardgameList.first),
      itemBuilder: (buildContext, index) {
        return boardGameItem(controller.filteredList[index]);
      },
    );
  }

  Widget boardGameItem(Boardgame game) {
    return Container(
        color: !game.available ? Colors.red[100] : null,
        child: Column(children: [
          const SizedBox(height: 10),
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
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.public)),
                  ])),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.grey)
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
