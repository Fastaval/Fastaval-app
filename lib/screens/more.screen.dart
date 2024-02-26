import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: backgroundBoxDecorationStyle,
              ),
              SizedBox(
                  height: double.infinity,
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          menuCard('Notifikationer',
                              Icons.notifications_active_outlined, true),
                          ListTile(
                            leading: const Icon(Icons.sports_esports),
                            title: Text(tr('drawer.boardgames'),
                                style: TextStyle(fontSize: 18)),
                            /*onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(context
                                   MaterialPageRoute(
                                    builder: (context) => BoardgameScreen(
                           boardgames: _boardgames, 
                            updateTime: _boardgameFetchTime,
                            updateParent: (games) => _updateBoardGames(games), 
                                        )),
                                  );
                            },*/
                          ),
                          menuCard('Brætspil', Icons.sports_esports, true),
                          menuCard('Kort over skolen', Icons.school),
                          menuCard(
                              'Kort over idrætshallen', Icons.sports_tennis),
                          SizedBox(height: 50),
                          menuCard('Indstillinger', Icons.settings, true),
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
}
