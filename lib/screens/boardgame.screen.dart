import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/boardgame.model.dart';
import 'package:fastaval_app/services/boardgame.service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardgameScreen extends StatefulWidget {
  final int updateTime;
  final List<Boardgame> boardgames;
  final Function updateParent;

  const BoardgameScreen({
    Key? key,
    required this.boardgames,
    required this.updateTime,
    required this.updateParent,
  }) : super(key: key);

  @override
  State<BoardgameScreen> createState() => _BoardgameScreen();
}

class _BoardgameScreen extends State<BoardgameScreen> {
  late List<Boardgame> boardgameList = widget.boardgames;
  late List<Boardgame> filteredList = widget.boardgames;
  late int listUpdatedAt = widget.updateTime;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: Text(tr('drawer.boardgames')),
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
                    onRefresh: () async {
                      fetchBoardgames().then((gamesList) => {
                            setState(() {
                              widget.updateParent(gamesList);
                              boardgameList = gamesList;
                              listUpdatedAt =
                                  (DateTime.now().millisecondsSinceEpoch / 1000)
                                      .round();
                              applyFilterToList();
                            }),
                          });
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                              padding: kCardMargin,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) => applyFilterToList(),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: tr("boardgames.search"),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => {
                                      _searchController.clear(),
                                      applyFilterToList()
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )),
                          buildBoardGames(),
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

  Widget buildBoardGames() {
    return textAndTextCard(
        tr('boardgames.title'),
        Text(
          "${tr('common.updated')} ${formatDay(listUpdatedAt, context)} ${formatTime(listUpdatedAt)}",
          style: kNormalTextSubdued,
        ),
        buildGame(context));
  }

  Widget buildGame(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredList.length,
      prototypeItem: boardGameItem(boardgameList.first),
      itemBuilder: (buildContext, index) {
        return boardGameItem(filteredList[index]);
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

  applyFilterToList() {
    String enteredKeyword = _searchController.text;
    List<Boardgame> results = [];
    if (enteredKeyword.isEmpty) {
      results = boardgameList;
    } else {
      results = boardgameList
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredList = results;
    });
  }
}
