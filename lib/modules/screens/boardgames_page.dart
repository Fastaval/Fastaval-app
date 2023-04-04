import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/boardgame.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoardGamePage extends StatefulWidget {
  final List<BoardGame> boardgames;
  const BoardGamePage({Key? key, required this.boardgames}) : super(key: key);

  @override
  State<BoardGamePage> createState() => _BoardGamePageState();
}

class _BoardGamePageState extends State<BoardGamePage> {
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
                    children: <Widget>[
                      const SizedBox(height: 10),
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
    return textAndIconCard(tr('notifications.title'), Icons.list_alt,
        buildGame(widget.boardgames.reversed.toList(), context));
  }

  Widget buildGame(List<BoardGame> games, BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: games.length,
      separatorBuilder: (context, int index) {
        return const Divider(
          height: 20,
          color: Colors.grey,
        );
      },
      itemBuilder: (buildContext, index) {
        return boardGameItem(games[index]);
      },
    );
  }

  Widget boardGameItem(BoardGame game) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              game.name as String,
              style: kNormalTextBoldStyle,
            ),
            Text(game.fastavalGame as bool
                ? "Fastaval spil"
                : "") // fastaval spil
          ])),
      Expanded(child: Text(game.available as bool ? "Ledig" : "ikke ledig"))
    ]);
  }
}
