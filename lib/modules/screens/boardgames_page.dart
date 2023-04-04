import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/boardgame.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class BoardGamePage extends StatefulWidget {
  late List<BoardGame> boardgames = List.empty(growable: true);

  BoardGamePage({Key? key}) : super(key: key);

  @override
  State<BoardGamePage> createState() => _BoardGamePageState();
}

class _BoardGamePageState extends State<BoardGamePage> {
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
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                          padding: kCardMargin,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: tr("boardgames.search"),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => _searchController.clear(),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardGames() {
    return textAndIconCard(
        tr('boardgames.title'), Icons.list_alt, buildGame(context));
  }

  Widget buildGame(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.boardgames.length,
      separatorBuilder: (context, int index) {
        return const Divider(height: 20, color: Colors.grey);
      },
      itemBuilder: (buildContext, index) {
        return boardGameItem(widget.boardgames[index]);
      },
    );
  }

  Widget boardGameItem(BoardGame game) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(game.name as String, style: kNormalTextBoldStyle),
      Text(tr("boardgames.gameAvailable.${game.available}"))
    ]);
  }
}
