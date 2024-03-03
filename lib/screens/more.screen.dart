import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/screens/boardgame.screen.dart';
import 'package:fastaval_app/screens/notifications.screen.dart';
import 'package:fastaval_app/screens/settings.screen.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 25,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('screenTitle.more')),
      ),
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
                          InkWell(
                            child: menuCard(tr('notifications.title'),
                                Icons.notifications_active_outlined, true),
                            onTap: () => Get.to(() => NotificationsScreen(),
                                transition: Transition.rightToLeft),
                          ),
                          InkWell(
                            child: menuCard(tr('boardgames.title'),
                                Icons.sports_esports_outlined, true),
                            onTap: () => Get.to(() => BoardgameScreen(),
                                transition: Transition.rightToLeft),
                          ),
                          InkWell(
                              child:
                                  menuCard(tr('more.map.school'), Icons.school),
                              onTap: () => fastaMap(
                                  context,
                                  const AssetImage(
                                      'assets/images/Mariagerfjord_kort_23.jpg'))),
                          InkWell(
                              child: menuCard(
                                  tr('more.map.gym'), Icons.sports_tennis),
                              onTap: () => fastaMap(
                                  context,
                                  const AssetImage(
                                      'assets/images/Hobro_Idraetscenter_kort_23.jpg'))),
                          SizedBox(height: 50),
                          InkWell(
                            child: menuCard(
                                tr('more.settings'), Icons.settings, true),
                            onTap: () => Get.to(() => SettingsScreen(context),
                                transition: Transition.rightToLeft),
                          ),
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

Future fastaMap(BuildContext context, AssetImage image) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(children: [
          PhotoView(imageProvider: image),
          Positioned(
              right: 10,
              top: 10,
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 20,
                  child: IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context)),
                ),
              ))
        ]);
      });
}