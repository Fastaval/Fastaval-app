import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/helpers/notification.dart';
import 'package:fastaval_app/models/food.model.dart';
import 'package:fastaval_app/models/scheduling.model.dart';
import 'package:fastaval_app/models/user.model.dart';
import 'package:fastaval_app/models/wear.model.dart';
import 'package:fastaval_app/services/user.service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  final int updateTime;
  final User user;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.updateTime,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 25,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('screenTitle.profile')),
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
                    onRefresh: () async {
                      fetchUser(
                        widget.user.id.toString(),
                        widget.user.password.toString(),
                      ).then((newUser) => scheduleMicrotask(() {
                            newUser.password = widget.user.password.toString();

                            UserNotification(loggedIn: true, user: newUser)
                                .dispatch(context);
                          }));
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          buildIdIcon(),
                          if (widget.user.messages.isNotEmpty)
                            buildUserMessagesCard(),
                          buildUserProgramCard(),
                          buildUserWearCard(),
                          buildUserSleepCard(),
                          if (widget.user.food.isNotEmpty)
                            buildUserFoodTimesCard(),
                          const SizedBox(height: 30.0),
                          buildLogoutButton(),
                          const SizedBox(height: 30.0),
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

  Widget buildIdIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Text(
            widget.user.id.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 58, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          tr('profile.participantNumber'),
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildLogoutButton() {
    return Padding(
        padding: const EdgeInsets.all(40),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () => {
              UserService().removeUser(),
              UserNotification(loggedIn: false, user: null).dispatch(context)
            },
            child: Text(
              tr('login.signOut'),
              style: const TextStyle(
                  color: Colors.deepOrange,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget buildUserFoodTimesCard() {
    return textAndIconCard(
        tr('profile.foodTimes'), Icons.fastfood, foodTickets(widget.user.food));
  }

  Widget buildUserMessagesCard() {
    String message = tr('profile.noMessagesRightNow');
    if (widget.user.messages.isNotEmpty) message = widget.user.messages;
    return textAndIconCard(tr('profile.messagesFromFastaval'),
        Icons.speaker_notes, Text(message, style: kNormalTextStyle));
  }

  Widget buildUserProgramCard() {
    return textAndTextCard(
        tr('profile.yourProgram'),
        Text(
          "${tr('common.updated')} ${formatDay(widget.updateTime, context)} ${formatTime(widget.updateTime)}",
          style: kNormalTextSubdued,
        ),
        buildUsersProgram(widget.user.scheduling, context));
  }

  Widget buildUsersProgram(List<Scheduling> schedule, context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: schedule.length,
      separatorBuilder: (context, int index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (buildContext, index) {
        return userProgramItem(schedule[index]);
      },
    );
  }

  Widget userProgramItem(Scheduling item) {
    var title =
        context.locale.languageCode == 'da' ? item.titleDa! : item.titleEn!;
    var room = context.locale.languageCode == 'da' ? item.roomDa : item.roomEn;
    var activityType = item.activityType != null &&
            (item.activityType == 'ottoviteter' ||
                item.activityType == 'system')
        ? ''
        : "- ${tr('profile.activityType.${item.activityType}')}";

    return InkWell(
        onTap: () => showDialog(
            context: context,
            builder: activityDialog,
            routeSettings: RouteSettings(arguments: item)),
        child: Column(children: [
          Row(children: [
            Text(
                "${formatDay(item.start, context)} ${formatTime(item.start)}-${formatTime(item.stop)}",
                style: kNormalTextBoldStyle),
            Flexible(
                child: Text(" @ $room $activityType",
                    style: kNormalTextSubdued, overflow: TextOverflow.ellipsis))
          ]),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: [
              Flexible(
                  child: Text(title,
                      overflow: TextOverflow.ellipsis, style: kNormalTextStyle))
            ]),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.grey)
        ]));
  }

  Widget foodTickets(List<Food> food) {
    return Column(children: [
      Text(tr('program.explainer'), style: kNormalTextSubdued),
      const SizedBox(height: 10),
      for (var item in food)
        InkWell(
          onTap: () => showDialog(
              context: context,
              builder: foodDialog,
              routeSettings: RouteSettings(arguments: item)),
          child: Card(
            color: getBackgroundColor(item),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
              child: Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                          context.locale.languageCode == 'da'
                              ? item.titleDa
                              : item.titleEn,
                          style: item.received == 1
                              ? kNormalTextDisabled
                              : kNormalTextBoldStyle),
                      Text(
                          "${formatDay(item.time, context)} ${formatTime(item.time)} - ${formatTime(item.timeEnd)}",
                          style: item.received == 1
                              ? kNormalTextDisabled
                              : kNormalTextSubdued),
                    ])),
                Row(
                  children: [
                    Text(tr('profile.foodTicket'),
                        style: item.received == 1
                            ? kNormalTextDisabled
                            : kNormalTextStyle),
                    const SizedBox(width: 5),
                    Icon(Icons.info_outline,
                        color: item.received == 1
                            ? Colors.black26
                            : Colors.black87)
                  ],
                ),
              ]),
            ),
          ),
        )
    ]);
  }

  Widget buildUserWearCard() {
    if (widget.user.wear.isEmpty) {
      return textAndIconCard((tr('profile.wear.title')), Icons.bed,
          oneTextRow(tr('profile.wear.noWear')));
    }

    return textAndIconCard(
        tr('profile.wear.title'),
        Icons.checkroom,
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.user.wear.length,
          separatorBuilder: (context, int index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (buildContext, index) {
            return wearItem(widget.user.wear[index]);
          },
        ));
  }

  Widget wearItem(Wear item) {
    String title = context.locale.languageCode == 'da'
        ? "${item.amount} stk. ${item.titleDa}"
        : "${item.amount} pcs. ${item.titleEn}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(title, style: kNormalTextStyle)),
        Text(tr('profile.wear.received.${item.received}'),
            style: kNormalTextBoldStyle)
      ],
    );
  }

  Widget buildUserSleepCard() {
    if (widget.user.sleep.access == 0) {
      return textAndIconCard((tr('profile.sleep.title')), Icons.bed,
          oneTextRow(tr('profile.sleep.notSleeping')));
    }

    return textAndIconCard(
        tr('profile.sleep.title'),
        Icons.bed,
        Column(children: [
          twoTextRow(tr('profile.sleep.location'), widget.user.sleep.areaName),
          const SizedBox(height: 10),
          twoTextRow(tr('profile.sleep.mattressRented'),
              tr('profile.sleep.mattress.${widget.user.sleep.mattress}'))
        ]));
  }

  getFoodImage(Food item) {
    if (item.titleEn.contains('Dinner')) {
      return 'assets/images/dinner.jpg';
    }
    if (item.titleEn.contains('Breakfast')) {
      return 'assets/images/breakfast.jpg';
    }
    return 'assets/images/lunch.jpg';
  }

  getActivityImage(Scheduling item) {
    switch (item.activityType) {
      case 'gds':
        return 'assets/images/gds.jpg';
      case 'spilleder':
        return 'assets/images/gamemaster.jpg';
      case 'rolle':
        return 'assets/images/player.jpg';
      case 'braet':
        return 'assets/images/boardgame.jpg';
      case 'junior':
        return 'assets/images/junior.jpg';
      default:
        return 'assets/images/fastaval.jpg';
    }
  }

  Color getBackgroundColor(Food item) {
    if (item.received == 1) return colorGrey;
    if (item.titleEn.contains('Dinner')) return colorOrangeLight;
    if (item.titleEn.contains('Breakfast')) return colorOrangeLight;
    return const Color(0xFF63BAAB);
  }

  Widget foodDialog(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Food;
    bool foodAvailable = item.received == 1 ? false : true;

    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('common.close')))
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: const EdgeInsets.all(0),
        title: Column(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(getFoodImage(item)), fit: BoxFit.cover),
              ),
              height: 100),
          const SizedBox(height: 5),
          Text(
              context.locale.languageCode == 'da' ? item.titleDa : item.titleEn)
        ]),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(context.locale.languageCode == 'da' ? item.textDa : item.textEn,
              style: kNormalTextStyle),
          if (item.titleEn.contains('Breakfast'))
            Text(tr('profile.breakfastText'), style: kNormalTextSubdued),
          const SizedBox(height: 10),
          if (foodAvailable == false)
            Text(tr('profile.foodHandedOut'), style: kNormalTextSubdued),
          if (foodAvailable)
            Text(
                "${tr('profile.handout')}: ${formatDay(item.time, context)} ${formatTime(item.time)} - ${formatTime(item.timeEnd)}",
                style: kNormalTextSubdued),
          if (foodAvailable) const SizedBox(height: 10),
          if (foodAvailable)
            BarcodeWidget(
                barcode: Barcode.ean8(), data: widget.user.barcode.toString()),
          if (foodAvailable) const SizedBox(height: 30),
          if (foodAvailable)
            Text(tr('profile.scanBarcode'), style: kNormalTextSubdued)
        ]));
  }

  Widget activityDialog(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Scheduling;

    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('common.close')))
        ],
        titlePadding: const EdgeInsets.all(0),
        title: Column(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                image: DecorationImage(
                    image: AssetImage(getActivityImage(item)),
                    fit: BoxFit.cover),
              ),
              height: 100),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(context.locale.languageCode == 'da'
                  ? item.titleDa!
                  : item.titleEn!))
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${tr('common.type')}: ', style: kNormalTextBoldStyle),
                Flexible(
                    child:
                        Text(tr('profile.activityType.${item.activityType}')))
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('${tr('common.time')}: ', style: kNormalTextBoldStyle),
                Text(
                    "${formatDay(item.start, context)} ${formatTime(item.start)} - ${formatTime(item.stop)}")
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${tr('common.place')}: ', style: kNormalTextBoldStyle),
                Flexible(
                    child: Text(context.locale.languageCode == 'da'
                        ? item.roomDa!
                        : item.roomEn!))
              ],
            ),
          ],
        ));
  }
}
