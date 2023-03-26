import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/helpers/formatting.dart';
import 'package:fastaval_app/config/models/food.dart';
import 'package:fastaval_app/config/models/scheduling.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/modules/notifications/login_notification.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  final User appUser;

  const ProfileScreen({Key? key, required this.appUser}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<String>> futureNumbersList;

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
                    onRefresh: () async {
                      //await Future.delayed(Duration(milliseconds: 1500));
                      await UserService().refreshUser();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          buildIdIcon(),
                          buildUserMessagesCard(),
                          buildUserProgramCard(),
                          if (widget.appUser.food!.isNotEmpty)
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

  Widget buildFoodListRows(List<Food>? food) {
    return Column(children: [
      ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: food!.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            Food item = food[index];
            return Card(
                color: getBackgroundColor(item),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                elevation: kCardElevation,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            getFoodImage(item),
                            height: 48.0,
                            width: 48.0,
                          ),
                        )),
                    Column(
                      children: [
                        Row(children: [
                          Text(
                            context.locale.toString() == 'en'
                                ? item.titleEn!
                                : item.titleDa!,
                            style: TextStyle(backgroundColor: Colors.red),
                          )
                        ]),
                        Row(children: const [
                          Text(
                            'test2',
                            textAlign: TextAlign.left,
                            style: TextStyle(backgroundColor: Colors.red),
                          )
                        ])
                      ],
                    ),
                  ],
                ));
          })
    ]);
  }

  Widget buildIdIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Text(
            widget.appUser.id.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'),
          ),
        ),
        Text(
          tr('profile.participantNumber'),
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
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
              LoginNotification(loggedIn: false, user: null).dispatch(context)
            },
            child: Text(
              tr('login.signOut'),
              style: const TextStyle(
                  color: Colors.deepOrange,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ));
  }

  Widget buildUserFoodTimesCard() {
    return (Column(children: [
      ListTile(
          title: Text(tr('profile.foodTimes'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ))),
      buildFoodListRows(widget.appUser.food)
    ]));

    /* return textAndIconCard(tr('profile.foodTimes'), Icons.fastfood,
        buildFoodListRows(widget.appUser.food)); */
  }

  Widget buildUserMessagesCard() {
    String message = tr('profile.noMessagesRightNow');
    if (widget.appUser.messages!.isNotEmpty) message = widget.appUser.messages!;
    return textAndIconCard(tr('profile.messagesFromFastaval'),
        Icons.speaker_notes, Text(message, style: kNormalTextStyle));
  }

  Widget buildUserProgramCard() {
    return textAndIconCard(tr('profile.yourProgram'), Icons.date_range,
        buildUsersProgram(widget.appUser.scheduling!, context));
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
        context.locale.toString() == 'en' ? item.titleEn! : item.titleDa!;
    var room = context.locale.toString() == 'en' ? item.roomEn! : item.roomDa!;

    return Column(children: [
      Row(children: [
        Text("${formatDay(item.start, context)} ${formatTime(item.start)}",
            style: kNormalTextBoldStyle),
        Text(" @ $room",
            style: kNormalTextStyle, overflow: TextOverflow.ellipsis)
      ]),
      Row(children: [oneTextRow(title, sidePadding: true)])
    ]);
  }

  String getFoodImage(Food item) {
    if (item.titleEn!.contains('Dinner')) {
      return 'assets/images/dinner.jpg';
    }
    if (item.titleEn!.contains('Breakfast')) {
      return 'assets/images/breakfast.jpg';
    }
    return 'assets/images/lunch.jpg';
  }

  Color getBackgroundColor(Food item) {
    if (item.titleEn!.contains('Dinner')) {
      return const Color(0xFFFFE8D1);
    }
    if (item.titleEn!.contains('Breakfast')) {
      return const Color(0xFFEFB695);
    }
    return const Color(0xFF63BAAB);
  }
}

class NumberGenerator {
  Future<List<String>> slowNumbers() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => numbers,
    );
  }

  List<String> get numbers => List.generate(5, (index) => number);

  String get number => Random().nextInt(99999).toString();
}
