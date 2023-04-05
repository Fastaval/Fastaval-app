import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/helpers/formatting.dart';
import 'package:fastaval_app/config/models/boardgame.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/utils/services/boardgame_service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoardgameScreen extends StatefulWidget {
  final int updateTime;
  final List<Boardgame> boardgames;

  const BoardgameScreen({
    Key? key,
    required this.boardgames,
    required this.updateTime,
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
      prototypeItem: boardGameItem(filteredList.first),
/*       separatorBuilder: (context, int index) {
        return const Divider(height: 20, color: Colors.grey);
      }, */
      itemBuilder: (buildContext, index) {
        return boardGameItem(filteredList[index]);
      },
    );
  }

  Widget boardGameItem(Boardgame game) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            game.name,
            style: kNormalTextBoldStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Text(tr("boardgames.gameAvailable.${game.available}")),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.grey)
        ]));
  }

  void applyFilterToList() {
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
