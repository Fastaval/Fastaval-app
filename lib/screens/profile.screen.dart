import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/app.controller.dart';
import 'package:fastaval_app/controllers/program.controller.dart';
import 'package:fastaval_app/controllers/settings.controller.dart';
import 'package:fastaval_app/helpers/collections.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/food.model.dart';
import 'package:fastaval_app/models/scheduling.model.dart';
import 'package:fastaval_app/models/wear.model.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final appController = Get.find<AppController>();
  final settingsController = Get.find<SettingsController>();
  final programCtrl = Get.find<ProgramController>();

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
                  backgroundColor: colorWhite,
                  color: colorOrange,
                  onRefresh: () => appController.updateUserProfile(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Obx(() => Column(
                          children: [
                            buildIdIcon(),
                            buildUserProgramCard(),
                            buildUserFoodTimesCard(),
                            buildUserSleepCard(),
                            buildUserWearCard(),
                            SizedBox(height: 30.0),
                            buildLogoutButton(),
                            SizedBox(height: 30.0),
                          ],
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildIdIcon() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.41),
                    border: Border.all(color: colorWhite, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row())
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      appController.user.id.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  tr('profile.participantNumber'),
                  style: TextStyle(
                    color: colorOrange,
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])
            ],
          )
        ],
      ),
    );
  }

  Widget buildLogoutButton() {
    return Padding(
        padding: EdgeInsets.all(40),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () => {appController.logout()},
            child: Text(
              tr('login.signOut'),
              style: TextStyle(
                  color: Colors.deepOrange,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget buildUserProgramCard() {
    return textAndTextCard(
        tr('profile.yourProgram'),
        "${tr('common.updated')} ${formatDay(appController.userUpdateTime.value)} ${formatTime(appController.userUpdateTime.value)}",
        buildUsersProgram(appController.user.scheduling));
  }

  Widget buildUsersProgram(List<Scheduling> schedule) {
    return Column(
      children: [
        SizedBox(height: 8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: schedule.length,
          separatorBuilder: (context, int index) {
            return SizedBox(height: 0);
          },
          itemBuilder: (buildContext, index) {
            return userProgramItem(schedule[index]);
          },
        ),
        SizedBox(height: 8)
      ],
    );
  }

  Widget userProgramItem(Scheduling item) {
    var room = Get.locale!.languageCode == 'da' ? item.roomDa : item.roomEn;
    var title =
        Get.locale!.languageCode == 'da' ? item.titleDa! : item.titleEn!;
    var activityType = '';
    if (item.activityType != null &&
        (item.activityType == 'ottoviteter' || item.activityType == 'system')) {
      activityType = '';
    } else {
      activityType = tr('profile.activityType.${item.activityType}');
    }
    var expired = DateTime.now()
        .isAfter(DateTime.fromMillisecondsSinceEpoch(item.stop! * 1000));

    return InkWell(
      onTap: () => showDialog(
          context: Get.context!,
          builder: activityDialog,
          routeSettings: RouteSettings(arguments: item)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.75),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: expired == true
              ? Color(0xFFD4E9EC)
              : getActivityColor(item.activityType!),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Text(
                          "${formatDay(item.start)} ${formatTime(item.start)}-${formatTime(item.stop)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: expired ? Colors.black26 : Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Flexible(
                          child: Text("$activityType @ $room",
                              style: expired
                                  ? kNormalTextSubduedExpired
                                  : kNormalTextSubdued,
                              overflow: TextOverflow.ellipsis)),
                    ]),
                    Text(title,
                        overflow: TextOverflow.ellipsis,
                        style:
                            expired ? kNormalTextDisabled : kNormalTextStyle),
                  ])),
              Icon(
                CupertinoIcons.doc_text_viewfinder,
                color: expired ? Colors.black26 : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserFoodTimesCard() {
    return textAndIconCard(tr('profile.foodTimes'), Icons.fastfood_outlined,
        buildUsersFoodTickets(appController.user.food));
  }

  Widget buildUsersFoodTickets(List<Food> foodList) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: foodList.isNotEmpty
            ? Text(tr('program.food.ordered'), style: kNormalTextSubdued)
            : Text(tr('program.food.notOrdered'), style: kNormalTextStyle),
      ),
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: foodList.length,
        separatorBuilder: (context, int index) {
          return SizedBox(height: 0);
        },
        itemBuilder: (buildContext, index) {
          return foodTickets(foodList[index]);
        },
      ),
      SizedBox(height: 8)
    ]);
  }

  Widget foodTickets(Food foodItem) {
    return InkWell(
      onTap: () => showDialog(
          context: Get.context!,
          builder: foodDialog,
          routeSettings: RouteSettings(arguments: foodItem)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.75),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: getFoodColor(foodItem),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Text(
                          "${formatDay(foodItem.time)} ${formatTime(foodItem.time)} - ${formatTime(foodItem.timeEnd)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: foodItem.received == 0
                                  ? Colors.black
                                  : Colors.black26,
                              fontWeight: FontWeight.bold)),
                    ]),
                    Text(
                        Get.locale!.languageCode == 'da'
                            ? foodItem.titleDa
                            : foodItem.titleEn,
                        overflow: TextOverflow.ellipsis,
                        style: foodItem.received == 0
                            ? kNormalTextStyle
                            : kNormalTextDisabled),
                  ])),
              Row(children: [
                Text(tr('profile.foodTicket'),
                    style: foodItem.received == 0
                        ? kNormalTextStyle
                        : kNormalTextDisabled),
                SizedBox(width: 8),
                Icon(CupertinoIcons.barcode_viewfinder,
                    color:
                        foodItem.received == 0 ? Colors.black : Colors.black26)
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserWearCard() {
    return textAndIconCard(
        tr('profile.wear.title'),
        Icons.shopping_bag_outlined,
        Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 24, 16),
            child: appController.user.wear.isEmpty
                ? oneTextRow(tr('profile.wear.noWear'))
                : ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appController.user.wear.length,
                    separatorBuilder: (context, int index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (buildContext, index) {
                      return wearItem(appController.user.wear[index]);
                    },
                  )));
  }

  Widget wearItem(Wear item) {
    String title = settingsController.language.value == 'da'
        ? "${item.amount} stk. ${item.titleDa}"
        : "${item.amount} pcs. ${item.titleEn}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(title,
              style: kNormalTextStyle, overflow: TextOverflow.ellipsis),
        ),
        SizedBox(width: 8),
        Text(tr('profile.wear.received.${item.received}'),
            style: kNormalTextBoldStyle)
      ],
    );
  }

  Widget buildUserSleepCard() {
    return textAndIconCard(
        tr('profile.sleep.title'),
        CupertinoIcons.bed_double,
        Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 24, 16),
            child: appController.user.sleep.access == 0
                ? Row(children: [oneTextRow(tr('profile.sleep.notSleeping'))])
                : Column(children: [
                    twoTextRow(tr('profile.sleep.location'),
                        appController.user.sleep.areaName),
                    SizedBox(height: 10),
                    twoTextRow(tr('profile.sleep.mattressRented'),
                        tr('profile.sleep.mattress.${appController.user.sleep.mattress}'))
                  ])));
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
        return 'assets/images/junior.png';
      default:
        return 'assets/images/fastaval.png';
    }
  }

  Color getFoodColor(Food item) {
    if (item.received == 1) return Color(0xFFD4E9EC);
    if (item.titleEn.contains('Dinner')) return Color(0xFFDFE5D9);
    if (item.titleEn.contains('Breakfast')) return Color(0xFFFDEB89);
    return Color(0xFFD4E9EC);
  }

  Widget foodDialog(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as Food;
    bool foodAvailable = food.received == 1 ? false : true;

    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('common.close')))
        ],
        backgroundColor: colorWhite,
        surfaceTintColor: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: EdgeInsets.all(0),
        title: Column(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(getFoodImage(food)), fit: BoxFit.cover),
              ),
              height: 100),
          SizedBox(height: 5),
          Text(
              context.locale.languageCode == 'da' ? food.titleDa : food.titleEn)
        ]),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(context.locale.languageCode == 'da' ? food.textDa : food.textEn,
              style: kNormalTextStyle),
          if (food.titleEn.contains('Breakfast'))
            Text(tr('profile.breakfastText'), style: kNormalTextSubdued),
          SizedBox(height: 10),
          if (foodAvailable == false)
            Text(tr('profile.foodHandedOut'), style: kNormalTextSubdued),
          if (foodAvailable)
            Text(
                "${tr('profile.handout')}: ${formatDay(food.time)} ${formatTime(food.time)} - ${formatTime(food.timeEnd)}",
                style: kNormalTextSubdued),
          if (foodAvailable) SizedBox(height: 10),
          if (foodAvailable)
            BarcodeWidget(
                barcode: Barcode.ean8(),
                data: appController.user.barcode.toString()),
          if (foodAvailable) SizedBox(height: 30),
          if (foodAvailable)
            Text(tr('profile.scanBarcode'), style: kNormalTextSubdued)
        ]));
  }

  Widget activityDialog(BuildContext context) {
    ScrollController scrollController = ScrollController();
    var item = ModalRoute.of(context)!.settings.arguments as Scheduling;
    var details = programCtrl.activityMap[item.id]!;

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
        title: Column(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                image: DecorationImage(
                    image: AssetImage(getActivityImage(item)),
                    fit: BoxFit.cover),
              ),
              height: 100),
          SizedBox(height: 8),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(context.locale.languageCode == 'da'
                  ? item.titleDa!
                  : item.titleEn!))
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('${tr('common.type')}: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(tr('profile.activityType.${item.activityType}')),
            ]),
            SizedBox(height: 8),
            Row(children: [
              Text('${tr('common.time')}: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  "${formatDay(item.start)} ${formatTime(item.start)} - ${formatTime(item.stop)}"),
            ]),
            SizedBox(height: 8),
            Row(children: [
              Text('${tr('common.place')}: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(context.locale.languageCode == 'da'
                  ? item.roomDa!
                  : item.roomEn!),
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
        ));
  }
}
