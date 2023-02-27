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
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          buildIdIcon(),
                          buildUserMessagesCard(),
                          buildUserProgramCard(),
                          buildUserFoodTimesCard(),
                          const SizedBox(height: 30.0),
                          buildLogoutButton(),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    )),
              )
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
            return Row(
              children: <Widget>[
                Expanded(flex: 2, child: Text(formatDay(item.time, context), style: kNormalTextBoldStyle)),
                Expanded(
                  flex: 7,
                  child: Text('${formatTime(item.time)} - ${formatTime(item.timeEnd)}', style: kNormalTextStyle),
                ),
                Expanded(
                  flex: 10,
                  child:
                      Text(context.locale.toString() == 'en' ? item.titleEn! : item.titleDa!, style: kNormalTextStyle),
                ),
              ],
            );
          })
    ]);
  }

  Widget buildIdIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Text(
            widget.appUser.id.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 58, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
          ),
        ),
        Text(
          tr('profile.participantNumber'),
          style:
              const TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0, fontWeight: FontWeight.bold),
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
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () =>
                {UserService().removeUser(), LoginNotification(loggedIn: false, user: null).dispatch(context)},
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
    return textAndIconCard(tr('profile.foodTimes'), Icons.fastfood, buildFoodListRows(widget.appUser.food));
  }

  Widget buildUserMessagesCard() {
    return textAndIconCard(tr('profile.messagesFromFastaval'), Icons.speaker_notes,
        Text(widget.appUser.messages ?? tr('profile.noMessagesRightNow'), style: kNormalTextStyle));
  }

  Widget buildUserProgramCard() {
    return textAndIconCard(
        tr('profile.yourProgram'), Icons.date_range, buildUsersProgram(widget.appUser.scheduling!, context));
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
    var title = context.locale.toString() == 'en' ? item.titleEn! : item.titleDa!;
    var room = context.locale.toString() == 'en' ? item.roomEn! : item.roomDa!;

    return Column(children: [
      Row(children: [
        Text("${formatDay(item.start, context)} ${formatTime(item.start)}", style: kNormalTextBoldStyle),
        Expanded(child: Text(" @ $room", style: kNormalTextStyle, overflow: TextOverflow.ellipsis))
      ]),
      Row(children: [oneTextRow(title, sidePadding: true)])
    ]);
  }
}
